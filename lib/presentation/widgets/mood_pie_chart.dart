import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sentiment_chatbot/core/config/design_config.dart';

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
              color: DesignConfig.saveButtonColor,
              value: positive.toDouble(),
              title: '😊 $positive',
              titleStyle: const TextStyle(
                  fontSize: DesignConfig.titleSize,
                  fontWeight: DesignConfig.semiBold
              ),
              radius: 60,
            ),
            PieChartSectionData(
              color: DesignConfig.viewMoodColor,
              value: neutral.toDouble(),
              title: '😐 $neutral',
              titleStyle: const TextStyle(
                  fontSize: DesignConfig.titleSize,
                  fontWeight: DesignConfig.semiBold
              ),
              radius: 60,
            ),
            PieChartSectionData(
              color: DesignConfig.cleanDataColor.withOpacity(0.8),
              value: negative.toDouble(),
              title: '😞 $negative',
              titleStyle: const TextStyle(
                fontSize: DesignConfig.titleSize,
                fontWeight: DesignConfig.semiBold
              ),
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
