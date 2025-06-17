import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/habit.dart';
import 'models/habit_entry.dart';
import 'models/mood_log.dart';
import 'presentation/screens/habit_tracker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(HabitEntryAdapter());
  Hive.registerAdapter(MoodLogAdapter());

  await Hive.openBox<Habit>('habits');
  await Hive.openBox<HabitEntry>('habit_entries');
  await Hive.openBox<MoodLog>('mood_logs');

  runApp(const HabitTrackerApp());
}
