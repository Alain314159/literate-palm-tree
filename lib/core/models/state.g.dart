// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StateAdapter extends TypeAdapter<State> {
  @override
  final int typeId = 5;

  @override
  State read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return State(
      id: fields[0] as String,
      userNpub: fields[1] as String,
      content: fields[2] as String?,
      mediaUrl: fields[3] as String?,
      mediaType: fields[4] as StateMediaType,
      createdAt: fields[5] as DateTime,
      expiresAt: fields[6] as DateTime,
      viewedBy: (fields[7] as List).cast<String>(),
      kind: fields[8] as int,
      eventId: fields[9] as String?,
      isMyState: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, State obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userNpub)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.mediaUrl)
      ..writeByte(4)
      ..write(obj.mediaType)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.expiresAt)
      ..writeByte(7)
      ..write(obj.viewedBy)
      ..writeByte(8)
      ..write(obj.kind)
      ..writeByte(9)
      ..write(obj.eventId)
      ..writeByte(10)
      ..write(obj.isMyState);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
