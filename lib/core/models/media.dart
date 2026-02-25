import 'package:hive/hive.dart';

part 'media.g.dart';

enum MediaType { image, video, audio, document, sticker }

@HiveType(typeId: 4)
class Media extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  MediaType type;

  @HiveField(2)
  String url; // URL de Nostr (NIP-96/Blossom)

  @HiveField(3)
  String? localPath; // Path local si está descargado

  @HiveField(4)
  int size; // Tamaño en bytes

  @HiveField(5)
  int? width;

  @HiveField(6)
  int? height;

  @HiveField(7)
  int? duration; // Duración en ms para audio/video

  @HiveField(8)
  String? mimeType;

  @HiveField(9)
  String? blurHash; // Para placeholder mientras carga

  @HiveField(10)
  DateTime createdAt;

  @HiveField(11)
  bool isDownloaded;

  @HiveField(12)
  String? messageId; // ID del mensaje asociado

  @HiveField(13)
  String? thumbnailUrl; // URL del thumbnail

  Media({
    required this.id,
    required this.type,
    required this.url,
    this.localPath,
    required this.size,
    this.width,
    this.height,
    this.duration,
    this.mimeType,
    this.blurHash,
    required this.createdAt,
    this.isDownloaded = false,
    this.messageId,
    this.thumbnailUrl,
  });

  Media copyWith({
    String? id,
    MediaType? type,
    String? url,
    String? localPath,
    int? size,
    int? width,
    int? height,
    int? duration,
    String? mimeType,
    String? blurHash,
    DateTime? createdAt,
    bool? isDownloaded,
    String? messageId,
    String? thumbnailUrl,
  }) {
    return Media(
      id: id ?? this.id,
      type: type ?? this.type,
      url: url ?? this.url,
      localPath: localPath ?? this.localPath,
      size: size ?? this.size,
      width: width ?? this.width,
      height: height ?? this.height,
      duration: duration ?? this.duration,
      mimeType: mimeType ?? this.mimeType,
      blurHash: blurHash ?? this.blurHash,
      createdAt: createdAt ?? this.createdAt,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      messageId: messageId ?? this.messageId,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'url': url,
      'localPath': localPath,
      'size': size,
      'width': width,
      'height': height,
      'duration': duration,
      'mimeType': mimeType,
      'blurHash': blurHash,
      'createdAt': createdAt.toIso8601String(),
      'isDownloaded': isDownloaded,
      'messageId': messageId,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'] as String,
      type: MediaType.values[json['type'] as int],
      url: json['url'] as String,
      localPath: json['localPath'] as String?,
      size: json['size'] as int,
      width: json['width'] as int?,
      height: json['height'] as int?,
      duration: json['duration'] as int?,
      mimeType: json['mimeType'] as String?,
      blurHash: json['blurHash'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isDownloaded: json['isDownloaded'] as bool? ?? false,
      messageId: json['messageId'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );
  }
}
