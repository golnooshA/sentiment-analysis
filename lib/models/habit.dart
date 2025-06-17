import 'package:hive/hive.dart';
part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime createdAt;

  Habit({required this.title, required this.createdAt});
}
