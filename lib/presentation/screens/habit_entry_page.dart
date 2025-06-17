import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../core/config/design_config.dart';
import '../../models/habit.dart';
import '../../models/habit_entry.dart';
import '../widgets/checkbox_tile.dart';

class HabitEntryPage extends StatefulWidget {
  const HabitEntryPage({super.key});

  @override
  State<HabitEntryPage> createState() => _HabitEntryPageState();
}

class _HabitEntryPageState extends State<HabitEntryPage> {
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

    for (var habit in _selectedHabits.entries) {
      await entryBox.add(HabitEntry(
        habitTitle: habit.key,
        date: todayDate,
        done: habit.value,
      ));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Habit entries saved.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Today Habits')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _selectedHabits.isEmpty
          ? const Center(
        child: Text(
          '📝 No habits found. Please add one first!',
          style: TextStyle(fontSize: 16),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
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
      floatingActionButton: _selectedHabits.isEmpty
          ? null
          : FloatingActionButton.extended(
        onPressed: _saveEntries,
        icon: const Icon(Icons.save, color: DesignConfig.textColor),
        label: const Text('Save', style: TextStyle(color: DesignConfig.textColor)),
        backgroundColor: DesignConfig.saveButtonColor,
      ),
    );
  }
}
