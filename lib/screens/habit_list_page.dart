import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/habit.dart';

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
      setState(() {});
    }
  }

  void _deleteHabit(int index) {
    Hive.box<Habit>('habits').deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final habits = Hive.box<Habit>('habits');

    return Scaffold(
      appBar: AppBar(title: const Text('My Habits')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _habitController,
                    decoration: const InputDecoration(hintText: 'Enter a habit'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addHabit,
                )
              ],
            ),
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
                    return ListTile(
                      title: Text(habit?.title ?? ''),
                      subtitle: Text(habit?.createdAt.toLocal().toString() ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteHabit(index),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
