import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/mood_log.dart';
import '../widgets/mood_log_list.dart';
import '../widgets/mood_pie_chart.dart';

class MoodTrendsPage extends StatelessWidget {
  const MoodTrendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Trends')),
      body: FutureBuilder(
        future: Hive.openBox<MoodLog>('mood_logs'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final box = Hive.box<MoodLog>('mood_logs');
          final logs = box.values.toList();

          if (logs.isEmpty) {
            return const Center(child: Text('No mood entries yet.'));
          }

          final positive = logs.where((e) => e.sentiment == 'Positive').length;
          final neutral = logs.where((e) => e.sentiment == 'Neutral').length;
          final negative = logs.where((e) => e.sentiment == 'Negative').length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Mood Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                MoodPieChart(positive: positive, neutral: neutral, negative: negative),
                const SizedBox(height: 24),
                Text('Recent Mood Entries:', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                MoodLogList(logs: logs),
              ],
            ),
          );
        },
      ),
    );
  }
}
