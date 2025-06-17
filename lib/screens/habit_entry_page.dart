import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/habit.dart';
import '../models/habit_entry.dart';

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
    final box = await Hive.openBox<Habit>('habits');
    final habits = box.values.toList();
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
    for (var habit in _selectedHabits.entries) {
      entryBox.add(HabitEntry(
        habitTitle: habit.key,
        date: DateTime(today.year, today.month, today.day),
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
          ? const Center(child: Text('📝 No habits found. Please add one first!'))
          : ListView(
        children: _selectedHabits.entries.map((entry) {
          return CheckboxListTile(
            title: Text(entry.key),
            value: entry.value,
            onChanged: (val) {
              setState(() => _selectedHabits[entry.key] = val ?? false);
            },
          );
        }).toList(),
      ),
      floatingActionButton: _selectedHabits.isEmpty
          ? null
          : FloatingActionButton.extended(
        onPressed: _saveEntries,
        icon: const Icon(Icons.save),
        label: const Text('Save'),
      ),
    );
  }
}
