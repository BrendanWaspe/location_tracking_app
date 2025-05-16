import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import '../providers/location_provider.dart';
import '../models/daily_summary.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Summary'),
      ),
      body: Consumer<LocationProvider>(
        builder: (context, provider, child) {
          final formattedDurations = provider.currentDayDurations.map(
            (key, value) => MapEntry(key, _formatDuration(value)),
          );
          formattedDurations['Traveling'] = _formatDuration(provider.currentDayTravelingDuration);

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: formattedDurations.length,
            itemBuilder: (context, index) {
              final entry = formattedDurations.entries.elementAt(index);
              return Card(
                child: ListTile(
                  title: Text(entry.key),
                  trailing: Text(
                    entry.value,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
} 