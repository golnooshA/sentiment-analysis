import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../core/config/design_config.dart';
import 'habit_list_page.dart';
import 'habit_entry_page.dart';
import 'habit_mood_page.dart';
import 'mood_log_page.dart';
import 'mood_trends_page.dart';
import '../models/habit.dart';
import '../models/habit_entry.dart';
import '../models/mood_log.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    const double buttonWidth = 220;
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Habit Tracker',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(DesignConfig.addHabbitColor),
            ),
            onPressed: () => navigateTo(context, const HabitListPage()),
            child: const Text('Add Habit', style: TextStyle(color: DesignConfig.buttonTextColor)),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(DesignConfig.habitCheckColor),
            ),
            onPressed: () => navigateTo(context, const HabitEntryPage()),
            child: const Text('Today Habit Check', style: TextStyle(color: DesignConfig.buttonTextColor)),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: buttonWidth,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(DesignConfig.addMoodColor),
              ),
              onPressed: () => navigateTo(context, const MoodLogPage()),
              child: const Text('Add Mood', style: TextStyle(color: DesignConfig.buttonTextColor)),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(DesignConfig.viewMoodColor),
                ),
                onPressed: () => navigateTo(context, const MoodTrendsPage()),
                child: const Text('Mood Trends', style: TextStyle(color: DesignConfig.buttonTextColor)),
              )),
          const SizedBox(height: 8),
          SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(DesignConfig.habbitMoodColor),
                ),
                onPressed: () => navigateTo(context, const HabitMoodInsightPage()),
                child: const Text('Habit Impact', style: TextStyle(color: DesignConfig.buttonTextColor)),
              )),
          const SizedBox(height: 8),
          SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(DesignConfig.cleanDataColor),
                ),
                onPressed: () {
                  clearAllHiveData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('🗑 All data cleared!')),
                  );
                },
                child: const Text('Clean All Data', style: TextStyle(color: DesignConfig.buttonTextColor)),
              )),
          ],
        ),
      ),
    );
  }
}


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
      await Hive.openBox(name); // تایپ فقط لازمه وقتی می‌خوای با Hive.box<T>() بازش کنی
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
