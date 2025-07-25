import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sentiment_chatbot/presentation/widgets/app_bar.dart';
import 'package:sentiment_chatbot/presentation/widgets/checkbox_tile.dart';
import 'package:sentiment_chatbot/presentation/widgets/mood_save_button.dart';
import '../../core/config/design_config.dart';
import '../../models/habit.dart';
import '../../models/habit_entry.dart';

class TodayHabitsPage extends StatefulWidget {
  const TodayHabitsPage({super.key});

  @override
  State<TodayHabitsPage> createState() => _TodayHabitsPageState();
}

class _TodayHabitsPageState extends State<TodayHabitsPage> {
  final Map<String, bool> _selectedHabits = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final habitBox = await Hive.openBox<Habit>('habits');
    final habits = habitBox.values.toList();

    setState(() {
      for (var habit in habits) {
        _selectedHabits[habit.title] = false;
      }
      _isLoading = false;
    });
  }

  Future<void> _saveEntries() async {
    final entryBox = await Hive.openBox<HabitEntry>('habit_entries');
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    for (var entry in _selectedHabits.entries) {
      await entryBox.add(HabitEntry(
        habitTitle: entry.key,
        date: todayDate,
        done: entry.value,
      ));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Habit entries saved.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDesign(title: 'Today Habits'),
      backgroundColor: DesignConfig.backgroundColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _selectedHabits.isEmpty
          ? const Center(
        child: Text(
          '📝 No habits found. Please add one first!',
          style: TextStyle(
            fontSize: DesignConfig.headerSize,
            color: DesignConfig.subTextColor,
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: _selectedHabits.entries.map((entry) {
            return CheckboxTile(
              title: entry.key,
              value: entry.value,
              onChanged: (val) {
                setState(() => _selectedHabits[entry.key] = val ?? false);
              },
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: _selectedHabits.isEmpty
          ? null
          : Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
        child: MoodSaveButton(onPressed: _saveEntries),
      ),
    );
  }
}
