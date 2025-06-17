import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/mood_log.dart';

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

          int positive = logs.where((e) => e.sentiment == 'Positive').length;
          int neutral = logs.where((e) => e.sentiment == 'Neutral').length;
          int negative = logs.where((e) => e.sentiment == 'Negative').length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Mood Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.green,
                          value: positive.toDouble(),
                          title: '😊 $positive',
                          radius: 60,
                        ),
                        PieChartSectionData(
                          color: Colors.blueGrey,
                          value: neutral.toDouble(),
                          title: '😐 $neutral',
                          radius: 60,
                        ),
                        PieChartSectionData(
                          color: Colors.red,
                          value: negative.toDouble(),
                          title: '😞 $negative',
                          radius: 60,
                        ),
                      ],
                      sectionsSpace: 4,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text('Recent Mood Entries:', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Expanded(
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}