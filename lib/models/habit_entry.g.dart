// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitEntryAdapter extends TypeAdapter<HabitEntry> {
  @override
  final int typeId = 1;

  @override
  HabitEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitEntry(
      habitTitle: fields[0] as String,
      date: fields[1] as DateTime,
      done: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HabitEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.habitTitle)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.done);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
