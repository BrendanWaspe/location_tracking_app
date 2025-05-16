import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import 'summary_screen.dart';
import 'map_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SummaryScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<LocationProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  provider.isTracking ? 'Currently Tracking' : 'Not Tracking',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (provider.isTracking) {
                        await provider.stopTracking();
                      } else {
                        await provider.startTracking();
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    backgroundColor: provider.isTracking ? Colors.red : Colors.green,
                  ),
                  child: Text(
                    provider.isTracking ? 'Clock Out' : 'Clock In',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                if (provider.isTracking) ...[
                  const SizedBox(height: 40),
                  const Text(
                    'Tracking your location...',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ],
                const SizedBox(height: 40),
                const Text(
                  'Geofences',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: provider.geoFences.length,
                    itemBuilder: (context, index) {
                      final geofence = provider.geoFences[index];
                      return Card(
                        child: ListTile(
                          title: Text(geofence.name),
                          subtitle: Text('Radius: ${geofence.radius}m'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await provider.removeGeofence(geofence);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
} 