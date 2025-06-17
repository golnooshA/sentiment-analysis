import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';
import '../../utils/hive_utils.dart';
import 'habit_list_page.dart';
import 'habit_entry_page.dart';
import 'habit_mood_page.dart';
import 'mood_log_page.dart';
import 'mood_trends_page.dart';
import '../widgets/evaluate_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker AI', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EvaluateButton(
                label: 'Add Habit',
                backgroundColor: DesignConfig.addHabbitColor,
                textColor: DesignConfig.buttonTextColor,
                onPressed: () => navigateTo(context, const HabitListPage()),
              ),
              const SizedBox(height: 12),

              EvaluateButton(
                label: 'Today Habit Check',
                backgroundColor: DesignConfig.habitCheckColor,
                textColor: DesignConfig.buttonTextColor,
                onPressed: () => navigateTo(context, const HabitEntryPage()),
              ),
              const SizedBox(height: 12),

              EvaluateButton(
                label: 'Add Mood',
                backgroundColor: DesignConfig.addMoodColor,
                textColor: DesignConfig.buttonTextColor,
                onPressed: () => navigateTo(context, const MoodLogPage()),
              ),
              const SizedBox(height: 12),

              EvaluateButton(
                label: 'Mood Trends',
                backgroundColor: DesignConfig.viewMoodColor,
                textColor: DesignConfig.buttonTextColor,
                onPressed: () => navigateTo(context, const MoodTrendsPage()),
              ),
              const SizedBox(height: 12),

              EvaluateButton(
                label: 'Habit Impact',
                backgroundColor: DesignConfig.habbitMoodColor,
                textColor: DesignConfig.buttonTextColor,
                onPressed: () => navigateTo(context, const HabitMoodInsightPage()),
              ),
              const SizedBox(height: 12),

              EvaluateButton(
                label: 'Clean All Data',
                backgroundColor: DesignConfig.cleanDataColor,
                textColor: DesignConfig.buttonTextColor,
                onPressed: () {
                  clearAllHiveData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('🗑 All data cleared!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

