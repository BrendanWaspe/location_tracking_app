import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../models/geo_fence.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final Set<Circle> _circles = {};
  final Set<Marker> _markers = {};
  LatLng? _selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Map'),
      ),
      body: Consumer<LocationProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.7749, -122.4194), // Default to San Francisco
                  zoom: 12,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                  _updateMapOverlays(provider);
                },
                onTap: (position) {
                  setState(() {
                    _selectedPosition = position;
                  });
                },
                circles: _circles,
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
              if (_selectedPosition != null)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      _showAddGeofenceDialog(context, provider);
                    },
                    child: const Icon(Icons.add_location),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _updateMapOverlays(LocationProvider provider) {
    _circles.clear();
    _markers.clear();

    for (final geofence in provider.geoFences) {
      _circles.add(
        Circle(
          circleId: CircleId(geofence.name),
          center: LatLng(geofence.latitude, geofence.longitude),
          radius: geofence.radius,
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ),
      );

      _markers.add(
        Marker(
          markerId: MarkerId(geofence.name),
          position: LatLng(geofence.latitude, geofence.longitude),
          infoWindow: InfoWindow(title: geofence.name),
          onTap: () {
            _showGeofenceOptions(context, provider, geofence);
          },
        ),
      );
    }

    setState(() {});
  }

  Future<void> _showAddGeofenceDialog(BuildContext context, LocationProvider provider) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController radiusController = TextEditingController(text: '50');

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Geofence'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Location Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: radiusController,
              decoration: const InputDecoration(labelText: 'Radius (meters)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && _selectedPosition != null) {
                provider.addGeofence(
                  GeoFence(
                    name: nameController.text,
                    latitude: _selectedPosition!.latitude,
                    longitude: _selectedPosition!.longitude,
                    radius: double.tryParse(radiusController.text) ?? 50.0,
                  ),
                );
                _updateMapOverlays(provider);
                setState(() {
                  _selectedPosition = null;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _showGeofenceOptions(BuildContext context, LocationProvider provider, GeoFence geofence) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(geofence.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Latitude: ${geofence.latitude}'),
            Text('Longitude: ${geofence.longitude}'),
            Text('Radius: ${geofence.radius}m'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () async {
              await provider.removeGeofence(geofence);
              _updateMapOverlays(provider);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
} 