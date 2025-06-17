// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodLogAdapter extends TypeAdapter<MoodLog> {
  @override
  final int typeId = 1;

  @override
  MoodLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodLog(
      moodText: fields[0] as String,
      sentiment: fields[1] as String,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MoodLog obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.moodText)
      ..writeByte(1)
      ..write(obj.sentiment)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
