import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../core/config/design_config.dart';
import '../../models/mood_log.dart';
import '../widgets/app_bar.dart';
import '../widgets/mood_log_list.dart';
import '../widgets/mood_pie_chart.dart';

class MoodTrendsPage extends StatelessWidget {
  const MoodTrendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDesign(title: 'Mood Trends'),
      backgroundColor: DesignConfig.backgroundColor,
      body: FutureBuilder(
        future: Hive.openBox<MoodLog>('mood_logs'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final box = Hive.box<MoodLog>('mood_logs');
          final logs = box.values.toList();

          if (logs.isEmpty) {
            return const Center(child:Text('📝 No habits found. Please add one first!',
                style: TextStyle(fontSize: DesignConfig.headerSize,
                    color: DesignConfig.subTextColor)));
          }

          final positive = logs.where((e) => e.sentiment == 'Positive').length;
          final neutral = logs.where((e) => e.sentiment == 'Neutral').length;
          final negative = logs.where((e) => e.sentiment == 'Negative').length;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                MoodPieChart(positive: positive, neutral: neutral, negative: negative),
                const SizedBox(height: 24),
                const Text('Recent Mood Entries:', style:  TextStyle(
                  fontSize: DesignConfig.titleSize,
                  color: DesignConfig.textColor
                )),
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
