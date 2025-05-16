import 'package:hive/hive.dart';

part 'geo_fence.g.dart';

@HiveType(typeId: 1)
class GeoFence {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double latitude;

  @HiveField(2)
  final double longitude;

  @HiveField(3)
  final double radius; // in meters

  GeoFence({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.radius = 50.0, // default 50m radius
  });

  factory GeoFence.fromJson(Map<String, dynamic> json) {
    return GeoFence(
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      radius: json['radius'] as double? ?? 50.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
    };
  }
} 