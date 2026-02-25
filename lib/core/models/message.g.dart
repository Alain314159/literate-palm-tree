// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 0;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      id: fields[0] as String,
      chatId: fields[1] as String,
      senderNpub: fields[2] as String,
      type: fields[3] as MessageType,
      content: fields[4] as String?,
      mediaUrl: fields[5] as String?,
      mediaThumbnail: fields[6] as String?,
      duration: fields[7] as int?,
      size: fields[8] as int?,
      timestamp: fields[9] as DateTime,
      status: fields[10] as MessageStatus,
      isOutgoing: fields[11] as bool,
      eventId: fields[12] as String?,
      kind: fields[13] as int,
      isDeleted: fields[14] as bool,
      replyToMessageId: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.chatId)
      ..writeByte(2)
      ..write(obj.senderNpub)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.mediaUrl)
      ..writeByte(6)
      ..write(obj.mediaThumbnail)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.size)
      ..writeByte(9)
      ..write(obj.timestamp)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.isOutgoing)
      ..writeByte(12)
      ..write(obj.eventId)
      ..writeByte(13)
      ..write(obj.kind)
      ..writeByte(14)
      ..write(obj.isDeleted)
      ..writeByte(15)
      ..write(obj.replyToMessageId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
