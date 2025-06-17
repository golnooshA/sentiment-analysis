import 'package:flutter/material.dart';

class MoodStatsCard extends StatelessWidget {
  final String habit;
  final int total;
  final int positive;
  final int neutral;
  final int negative;

  const MoodStatsCard({
    super.key,
    required this.habit,
    required this.total,
    required this.positive,
    required this.neutral,
    required this.negative,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📌 Habit: $habit', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('✅ Days Done: $total'),
            Text('😊 Positive Mood: $positive'),
            Text('😐 Neutral Mood: $neutral'),
            Text('😞 Negative Mood: $negative'),
          ],
        ),
      ),
    );
  }
}
