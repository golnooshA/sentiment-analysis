import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/config/design_config.dart';
import '../../models/habit.dart';
import '../widgets/app_bar.dart';
import '../widgets/habit_tile.dart';
import '../widgets/input_field.dart';

class MyHabitsPage extends StatefulWidget {
  const MyHabitsPage({super.key});

  @override
  _MyHabitsPageState createState() => _MyHabitsPageState();
}

class _MyHabitsPageState extends State<MyHabitsPage> {
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
      appBar: const AppBarDesign(title: 'My Habits'),
      backgroundColor: DesignConfig.backgroundColor,

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
                  return const Center(child: Text('📝 No habits found. Please add one first!',
                      style: TextStyle(fontSize: DesignConfig.headerSize,
                          color: DesignConfig.subTextColor)));
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
