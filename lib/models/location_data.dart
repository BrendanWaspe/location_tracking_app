import 'package:hive/hive.dart';

part 'location_data.g.dart';

@HiveType(typeId: 0)
class LocationData {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  final String? locationName;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.locationName,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      timestamp: DateTime.parse(json['timestamp'] as String),
      locationName: json['locationName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'locationName': locationName,
    };
  }
} 