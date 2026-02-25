// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 3;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      userNpub: fields[0] as String,
      theme: fields[1] as ThemeType,
      ultraSaveMode: fields[2] as bool,
      autoDownloadMedia: fields[3] as bool,
      imageQuality: fields[4] as double,
      maxImageSize: fields[5] as int,
      showReadReceipts: fields[6] as bool,
      showTypingIndicators: fields[7] as bool,
      defaultRelays: (fields[8] as List).cast<String>(),
      notificationsEnabled: fields[9] as bool,
      soundEnabled: fields[10] as bool,
      vibrationEnabled: fields[11] as bool,
      languageCode: fields[12] as String?,
      messageRetentionDays: fields[13] as int,
      hidePreview: fields[14] as bool,
      useFakeProfile: fields[15] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.userNpub)
      ..writeByte(1)
      ..write(obj.theme)
      ..writeByte(2)
      ..write(obj.ultraSaveMode)
      ..writeByte(3)
      ..write(obj.autoDownloadMedia)
      ..writeByte(4)
      ..write(obj.imageQuality)
      ..writeByte(5)
      ..write(obj.maxImageSize)
      ..writeByte(6)
      ..write(obj.showReadReceipts)
      ..writeByte(7)
      ..write(obj.showTypingIndicators)
      ..writeByte(8)
      ..write(obj.defaultRelays)
      ..writeByte(9)
      ..write(obj.notificationsEnabled)
      ..writeByte(10)
      ..write(obj.soundEnabled)
      ..writeByte(11)
      ..write(obj.vibrationEnabled)
      ..writeByte(12)
      ..write(obj.languageCode)
      ..writeByte(13)
      ..write(obj.messageRetentionDays)
      ..writeByte(14)
      ..write(obj.hidePreview)
      ..writeByte(15)
      ..write(obj.useFakeProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
