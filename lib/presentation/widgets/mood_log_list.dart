import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/mood_log.dart';

class MoodLogList extends StatelessWidget {
  final List<MoodLog> logs;

  const MoodLogList({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final mood = logs[logs.length - 1 - index];
          final date = DateFormat('yyyy-MM-dd').format(mood.timestamp);

          return ListTile(
            title: Text(mood.sentiment),
            subtitle: Text(mood.moodText),
            trailing: Text(date),
          );
        },
      ),
    );
  }
}
