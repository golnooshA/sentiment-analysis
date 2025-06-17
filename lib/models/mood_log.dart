import 'package:hive/hive.dart';
part 'mood_log.g.dart';

@HiveType(typeId: 1)
class MoodLog extends HiveObject {
  @HiveField(0)
  String moodText;

  @HiveField(1)
  String sentiment; // "Positive", "Neutral", "Negative"

  @HiveField(2)
  DateTime timestamp;

  MoodLog({required this.moodText, required this.sentiment, required this.timestamp});
}
