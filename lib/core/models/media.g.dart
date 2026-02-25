// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaAdapter extends TypeAdapter<Media> {
  @override
  final int typeId = 4;

  @override
  Media read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Media(
      id: fields[0] as String,
      type: fields[1] as MediaType,
      url: fields[2] as String,
      localPath: fields[3] as String?,
      size: fields[4] as int,
      width: fields[5] as int?,
      height: fields[6] as int?,
      duration: fields[7] as int?,
      mimeType: fields[8] as String?,
      blurHash: fields[9] as String?,
      createdAt: fields[10] as DateTime,
      isDownloaded: fields[11] as bool,
      messageId: fields[12] as String?,
      thumbnailUrl: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Media obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.localPath)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.width)
      ..writeByte(6)
      ..write(obj.height)
      ..writeByte(7)
      ..write(obj.duration)
      ..writeByte(8)
      ..write(obj.mimeType)
      ..writeByte(9)
      ..write(obj.blurHash)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.isDownloaded)
      ..writeByte(12)
      ..write(obj.messageId)
      ..writeByte(13)
      ..write(obj.thumbnailUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
