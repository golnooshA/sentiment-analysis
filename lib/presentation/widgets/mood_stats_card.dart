import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DesignConfig.backgroundColor,
        borderRadius: DesignConfig.border,
        border: Border.all(
          color: DesignConfig.primaryColor.withOpacity(0.3),
          width: 1.2,
        ),
      ),
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
    );
  }
}
