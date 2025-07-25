import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sentiment_chatbot/presentation/widgets/app_bar.dart';
import '../../core/config/design_config.dart';
import '../../models/habit_entry.dart';
import '../../models/mood_log.dart';
import '../../utils/mood_aggregation.dart';
import '../widgets/mood_stats_card.dart';

class HabitMoodInsightPage extends StatelessWidget {
  const HabitMoodInsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDesign(title: 'Habit Impact on Mood'),
      backgroundColor: DesignConfig.backgroundColor,

      body: FutureBuilder(
        future: Future.wait([
          Hive.openBox<HabitEntry>('habit_entries'),
          Hive.openBox<MoodLog>('mood_logs'),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final habitBox = Hive.box<HabitEntry>('habit_entries');
          final moodBox = Hive.box<MoodLog>('mood_logs');
          final habitEntries = habitBox.values.toList();
          final moodLogs = moodBox.values.toList();

          final moodPerHabit = computeHabitMoodLinks(habitEntries, moodLogs);

          if (moodPerHabit.isEmpty) {
            return const Center(
              child: Text(
                "❌ No matching habit and mood data found.",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: moodPerHabit.entries.map((entry) {
                final moods = entry.value;
                return MoodStatsCard(
                  habit: entry.key,
                  total: moods.length,
                  positive: moods.where((m) => m == 'Positive').length,
                  neutral: moods.where((m) => m == 'Neutral').length,
                  negative: moods.where((m) => m == 'Negative').length,
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
