import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/habit.dart';
import '../widgets/habit_tile.dart';
import '../widgets/input_field.dart';

class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key});

  @override
  _HabitListPageState createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  final TextEditingController _habitController = TextEditingController();

  void _addHabit() {
    final title = _habitController.text.trim();
    if (title.isNotEmpty) {
      final habit = Habit(title: title, createdAt: DateTime.now());
      Hive.box<Habit>('habits').add(habit);
      _habitController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  void _deleteHabit(int index) {
    Hive.box<Habit>('habits').deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    final habits = Hive.box<Habit>('habits');

    return Scaffold(
      appBar: AppBar(title: const Text('My Habits')),
      body: Column(
        children: [
          InputField(
            controller: _habitController,
            onAdd: _addHabit,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: habits.listenable(),
              builder: (context, Box<Habit> box, _) {
                if (box.values.isEmpty) {
                  return const Center(child: Text('No habits yet.'));
                }
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final habit = box.getAt(index);
                    if (habit == null) return const SizedBox.shrink();

                    return HabitTile(
                      habit: habit,
                      onDelete: () => _deleteHabit(index),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
