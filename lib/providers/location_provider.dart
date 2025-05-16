import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import '../models/location_data.dart';
import '../models/geo_fence.dart';
import '../models/daily_summary.dart';

class LocationProvider with ChangeNotifier {
  bool _isTracking = false;
  DateTime? _lastLocationUpdateTime;
  LocationData? _lastLocation;
  final List<GeoFence> _geoFences = [
    GeoFence(
      name: 'Home',
      latitude: 37.7749,
      longitude: -122.4194,
    ),
    GeoFence(
      name: 'Office',
      latitude: 37.7858,
      longitude: -122.4364,
    ),
  ];

  Map<String, Duration> _currentDayDurations = {};
  Duration _currentDayTravelingDuration = Duration.zero;
  StreamSubscription<Location>? _locationSubscription;

  bool get isTracking => _isTracking;
  List<GeoFence> get geoFences => List.unmodifiable(_geoFences);
  Map<String, Duration> get currentDayDurations => Map.unmodifiable(_currentDayDurations);
  Duration get currentDayTravelingDuration => _currentDayTravelingDuration;

  LocationProvider() {
    _initializeHive();
    _loadCurrentDaySummary();
    _loadGeofences();
  }

  Future<void> _initializeHive() async {
    if (!Hive.isBoxOpen('dailySummaries')) {
      await Hive.openBox<DailySummary>('dailySummaries');
    }
    if (!Hive.isBoxOpen('geofences')) {
      await Hive.openBox<GeoFence>('geofences');
    }
  }

  Future<void> _loadCurrentDaySummary() async {
    final today = DateTime.now();
    final box = Hive.box<DailySummary>('dailySummaries');
    final key = '${today.year}-${today.month}-${today.day}';
    
    if (box.containsKey(key)) {
      final summary = box.get(key)!;
      _currentDayDurations = Map.from(summary.locationDurations);
      _currentDayTravelingDuration = summary.travelingDuration;
      notifyListeners();
    }
  }

  Future<void> _loadGeofences() async {
    final box = Hive.box<GeoFence>('geofences');
    _geoFences.clear();
    _geoFences.addAll(box.values);
    notifyListeners();
  }

  void addGeofence(GeoFence geofence) {
    _geoFences.add(geofence);
    final box = Hive.box<GeoFence>('geofences');
    box.add(geofence);
    notifyListeners();
  }

  Future<void> removeGeofence(GeoFence geofence) async {
    _geoFences.remove(geofence);
    final box = Hive.box<GeoFence>('geofences');
    final index = box.values.toList().indexOf(geofence);
    if (index != -1) {
      await box.deleteAt(index);
    }
    notifyListeners();
  }

  Future<void> startTracking() async {
    if (_isTracking) return;

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requestPermission = await Geolocator.requestPermission();
      if (requestPermission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    await BackgroundLocation.setAndroidNotification(
      title: "Location Tracking",
      message: "Tracking your location",
      icon: "@mipmap/ic_launcher",
    );

    await BackgroundLocation.startLocationService();
    _locationSubscription = BackgroundLocation.getLocationUpdates((location) {
      _handleLocationUpdate(location);
    });

    _isTracking = true;
    notifyListeners();
  }

  Future<void> stopTracking() async {
    if (!_isTracking) return;

    await BackgroundLocation.stopLocationService();
    await _locationSubscription?.cancel();
    _locationSubscription = null;

    await _saveCurrentDaySummary();
    
    _isTracking = false;
    notifyListeners();
  }

  void _handleLocationUpdate(Location location) {
    final now = DateTime.now();
    final currentLocation = LocationData(
      latitude: location.latitude!,
      longitude: location.longitude!,
      timestamp: now,
    );

    if (_lastLocationUpdateTime != null) {
      final timeDelta = now.difference(_lastLocationUpdateTime!);
      _updateLocationDurations(_lastLocation!, currentLocation, timeDelta);
    }

    _lastLocation = currentLocation;
    _lastLocationUpdateTime = now;
  }

  void _updateLocationDurations(LocationData lastLocation, LocationData currentLocation, Duration timeDelta) {
    final currentGeoFences = _getCurrentGeoFences(currentLocation);
    final lastGeoFences = _getCurrentGeoFences(lastLocation);

    if (currentGeoFences.isEmpty && lastGeoFences.isEmpty) {
      // Both outside geo-fences, add to traveling time
      _currentDayTravelingDuration += timeDelta;
    } else {
      // Add time to each geo-fence the user is in
      for (final geoFence in currentGeoFences) {
        _currentDayDurations[geoFence.name] = (_currentDayDurations[geoFence.name] ?? Duration.zero) + timeDelta;
      }
    }

    notifyListeners();
  }

  List<GeoFence> _getCurrentGeoFences(LocationData location) {
    return _geoFences.where((geoFence) {
      final distance = Geolocator.distanceBetween(
        geoFence.latitude,
        geoFence.longitude,
        location.latitude,
        location.longitude,
      );
      return distance <= geoFence.radius;
    }).toList();
  }

  Future<void> _saveCurrentDaySummary() async {
    final today = DateTime.now();
    final box = Hive.box<DailySummary>('dailySummaries');
    final key = '${today.year}-${today.month}-${today.day}';

    final summary = DailySummary(
      date: today,
      locationDurations: Map.from(_currentDayDurations),
      travelingDuration: _currentDayTravelingDuration,
    );

    await box.put(key, summary);
  }

  @override
  void dispose() {
    stopTracking();
    super.dispose();
  }
}
