// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keys.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KeysAdapter extends TypeAdapter<Keys> {
  @override
  final int typeId = 2;

  @override
  Keys read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Keys(
      privateKey: fields[0] as String,
      publicKey: fields[1] as String,
      npub: fields[2] as String,
      nsec: fields[3] as String?,
      createdAt: fields[4] as DateTime,
      isImported: fields[5] as bool,
      backupHint: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Keys obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.privateKey)
      ..writeByte(1)
      ..write(obj.publicKey)
      ..writeByte(2)
      ..write(obj.npub)
      ..writeByte(3)
      ..write(obj.nsec)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.isImported)
      ..writeByte(6)
      ..write(obj.backupHint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeysAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
