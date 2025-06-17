import 'package:intl/intl.dart';

import '../models/habit_entry.dart';
import '../models/mood_log.dart';

Map<String, List<String>> computeHabitMoodLinks(List<HabitEntry> habits, List<MoodLog> moods) {
  final Map<String, List<String>> moodPerHabit = {};
  final formatter = DateFormat('yyyy-MM-dd');

  for (var habit in habits) {
    if (!habit.done) continue;

    final habitTime = habit.date;
    final formattedDate = formatter.format(habitTime);

    final matchedMood = moods.firstWhere(
          (m) => formatter.format(m.timestamp) == formattedDate && m.timestamp.isAfter(habitTime),
      orElse: () => MoodLog(
        moodText: '',
        sentiment: 'Unknown',
        timestamp: habitTime,
      ),
    );

    if (!moodPerHabit.containsKey(habit.habitTitle)) {
      moodPerHabit[habit.habitTitle] = [];
    }

    if (matchedMood.sentiment != 'Unknown') {
      moodPerHabit[habit.habitTitle]!.add(matchedMood.sentiment);
    }
  }

  return moodPerHabit;
}
