import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MoodPieChart extends StatelessWidget {
  final int positive;
  final int neutral;
  final int negative;

  const MoodPieChart({
    super.key,
    required this.positive,
    required this.neutral,
    required this.negative,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
