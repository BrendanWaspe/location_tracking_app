import 'package:hive/hive.dart';

part 'daily_summary.g.dart';

@HiveType(typeId: 2)
class DailySummary {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final Map<String, Duration> locationDurations;

  @HiveField(2)
  final Duration travelingDuration;

  DailySummary({
    required this.date,
    required this.locationDurations,
    required this.travelingDuration,
  });

  factory DailySummary.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> durations = json['locationDurations'] as Map<String, dynamic>;
    return DailySummary(
      date: DateTime.parse(json['date'] as String),
      locationDurations: durations.map(
        (key, value) => MapEntry(key, Duration(milliseconds: value as int)),
      ),
      travelingDuration: Duration(milliseconds: json['travelingDuration'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'locationDurations': locationDurations.map(
        (key, value) => MapEntry(key, value.inMilliseconds),
      ),
      'travelingDuration': travelingDuration.inMilliseconds,
    };
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  Map<String, String> getFormattedDurations() {
    final Map<String, String> formatted = {};
    locationDurations.forEach((key, value) {
      formatted[key] = formatDuration(value);
    });
    formatted['Traveling'] = formatDuration(travelingDuration);
    return formatted;
  }
} 