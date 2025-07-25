import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sentiment_chatbot/core/config/design_config.dart';
import '../../models/habit.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onDelete;

  const HabitTile({
    super.key,
    required this.habit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final String title = habit.title;
    final String createdAt = DateFormat('yyyy/MM/dd – HH:mm').format(habit.createdAt.toLocal());

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),

      title: Text(
        title,
        style: const TextStyle(
          color: DesignConfig.textColor,
          fontSize: DesignConfig.textSize,
          fontWeight: DesignConfig.semiBold,
        ),
      ),
      subtitle: Text(
        createdAt,
        style: const TextStyle(
          color: DesignConfig.textColor,
          fontSize: DesignConfig.subTextSize,
          fontWeight: DesignConfig.light,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
