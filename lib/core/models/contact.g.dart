// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final int typeId = 1;

  @override
  Contact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contact(
      npub: fields[0] as String,
      customName: fields[1] as String?,
      displayName: fields[2] as String?,
      about: fields[3] as String?,
      picture: fields[4] as String?,
      nip05: fields[5] as String?,
      relays: (fields[6] as List).cast<String>(),
      isBlocked: fields[7] as bool,
      lastSeen: fields[8] as DateTime?,
      lastMessageTime: fields[9] as DateTime?,
      unreadCount: fields[10] as int,
      isFavorite: fields[11] as bool,
      lastMessagePreview: fields[12] as String?,
      hasUnreadMention: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.npub)
      ..writeByte(1)
      ..write(obj.customName)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.about)
      ..writeByte(4)
      ..write(obj.picture)
      ..writeByte(5)
      ..write(obj.nip05)
      ..writeByte(6)
      ..write(obj.relays)
      ..writeByte(7)
      ..write(obj.isBlocked)
      ..writeByte(8)
      ..write(obj.lastSeen)
      ..writeByte(9)
      ..write(obj.lastMessageTime)
      ..writeByte(10)
      ..write(obj.unreadCount)
      ..writeByte(11)
      ..write(obj.isFavorite)
      ..writeByte(12)
      ..write(obj.lastMessagePreview)
      ..writeByte(13)
      ..write(obj.hasUnreadMention);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
