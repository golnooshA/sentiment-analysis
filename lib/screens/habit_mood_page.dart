import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/habit_entry.dart';
import '../models/mood_log.dart';
import 'package:intl/intl.dart';

class HabitMoodInsightPage extends StatelessWidget {
  const HabitMoodInsightPage({super.key});

  String _formatDate(DateTime dt) {
    return DateFormat('yyyy-MM-dd').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habit Impact on Mood')),
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

          Map<String, List<String>> moodPerHabit = {};

          for (var habit in habitEntries) {
            final habitDate = _formatDate(habit.date);
            final mood = moodLogs.firstWhere(
                  (m) => _formatDate(m.timestamp) == habitDate,
              orElse: () => MoodLog(moodText: '', sentiment: 'Unknown', timestamp: habit.date),
            );

            if (!moodPerHabit.containsKey(habit.habitTitle)) {
              moodPerHabit[habit.habitTitle] = [];
            }

            if (habit.done && mood.sentiment != 'Unknown') {
              moodPerHabit[habit.habitTitle]!.add(mood.sentiment);
            }
          }

          if (moodPerHabit.isEmpty) {
            return const Center(child: Text("❌ No matching habit and mood data found."));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: moodPerHabit.entries.map((entry) {
                final habit = entry.key;
                final moods = entry.value;
                final total = moods.length;
                final positive = moods.where((m) => m == 'Positive').length;
                final neutral = moods.where((m) => m == 'Neutral').length;
                final negative = moods.where((m) => m == 'Negative').length;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Habit: $habit', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('✅ Days Done: $total'),
                        Text('😊 Positive Mood: $positive'),
                        Text('😐 Neutral Mood: $neutral'),
                        Text('😞 Negative Mood: $negative'),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
