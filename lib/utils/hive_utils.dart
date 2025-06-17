import 'package:hive/hive.dart';
import '../models/habit.dart';
import '../models/habit_entry.dart';
import '../models/mood_log.dart';

Future<void> clearAllHiveData() async {
  final Map<String, Type> boxes = {
    'habits': Habit,
    'habit_entries': HabitEntry,
    'mood_logs': MoodLog,
  };

  for (var entry in boxes.entries) {
    final name = entry.key;
    final type = entry.value;

    if (!Hive.isBoxOpen(name)) {
      await Hive.openBox(name);
    }

    if (type == Habit) {
      await Hive.box<Habit>(name).clear();
    } else if (type == HabitEntry) {
      await Hive.box<HabitEntry>(name).clear();
    } else if (type == MoodLog) {
      await Hive.box<MoodLog>(name).clear();
    }
  }

  print('✅ All Hive data cleared.');
}
