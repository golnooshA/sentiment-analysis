import 'package:flutter/material.dart';
import 'package:sentiment_chatbot/presentation/screens/today_habit_page.dart';
import 'package:sentiment_chatbot/presentation/widgets/app_bar.dart';
import '../../core/config/design_config.dart';
import '../../utils/hive_utils.dart';
import 'habit_mood_page.dart';
import 'mood_log_page.dart';
import 'mood_trends_page.dart';
import '../widgets/evaluate_button.dart';
import 'my_habits.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConfig.backgroundColor,
      appBar: const AppBarDesign(title: 'Habit Tracker AI'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: DesignConfig.addHabbitColor,

                    borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),

                Image.asset(
                  'assets/images/vector.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            EvaluateButton(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              size: const Size(double.infinity, 50),
              label: 'Add Habit',
              backgroundColor: DesignConfig.addHabbitColor,
              onPressed: () => navigateTo(context, const MyHabitsPage()),
            ),
            const SizedBox(height: 16),
            EvaluateButton(
              label: 'Today Habit Check',
              backgroundColor: DesignConfig.habitCheckColor,
              onPressed: () => navigateTo(context, const TodayHabitsPage()),
            ),
            const SizedBox(height: 16),
            EvaluateButton(
              label: 'Add Mood',
              backgroundColor: DesignConfig.addMoodColor,
              onPressed: () => navigateTo(context, const MoodLogPage()),
            ),
            const SizedBox(height: 16),
            EvaluateButton(
              label: 'Mood Trends',
              backgroundColor: DesignConfig.viewMoodColor,
              onPressed: () => navigateTo(context, const MoodTrendsPage()),
            ),
            const SizedBox(height: 16),
            EvaluateButton(
              label: 'Habit Impact',
              backgroundColor: DesignConfig.habbitMoodColor,
              onPressed: () => navigateTo(context, const HabitMoodInsightPage()),
            ),
            const SizedBox(height: 16),
            EvaluateButton(
              label: 'Clean All Data',
              backgroundColor: DesignConfig.cleanDataColor,
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
    );
  }
}
