import 'package:hive/hive.dart';

part 'habit_entry.g.dart';

@HiveType(typeId: 2)
class HabitEntry extends HiveObject {
  @HiveField(0)
  String habitTitle;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  bool done;

  HabitEntry({required this.habitTitle, required this.date, required this.done});
}
