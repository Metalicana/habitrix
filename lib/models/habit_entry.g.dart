// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitEntryAdapter extends TypeAdapter<HabitEntry> {
  @override
  final int typeId = 2;

  @override
  HabitEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitEntry(
      habitId: fields[0] as String,
      entryDate: fields[1] as DateTime,
      entryAmount: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HabitEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.habitId)
      ..writeByte(1)
      ..write(obj.entryDate)
      ..writeByte(2)
      ..write(obj.entryAmount);
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
