import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class TripPlannerScreen extends StatefulWidget {
  const TripPlannerScreen({super.key});

  @override
  State<TripPlannerScreen> createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Planner'),
        backgroundColor: context.theme.appBar,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.travel_explore,
              size: 64,
              color: context.theme.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Trip Planner',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Plan and pack for your trips',
              style: TextStyle(color: context.theme.grey),
            ),
            const SizedBox(height: 16),
            Text(
              'Coming soon...',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: context.theme.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
