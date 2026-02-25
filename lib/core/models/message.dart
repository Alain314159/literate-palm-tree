import 'package:hive/hive.dart';

part 'message.g.dart';

enum MessageType { text, voice, image, video, sticker }

enum MessageStatus { sending, sent, delivered, read, failed }

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String chatId;

  @HiveField(2)
  String senderNpub;

  @HiveField(3)
  MessageType type;

  @HiveField(4)
  String? content; // Texto o contenido cifrado

  @HiveField(5)
  String? mediaUrl; // URL para imagen/video/voz/sticker

  @HiveField(6)
  String? mediaThumbnail;

  @HiveField(7)
  int? duration; // Duración en ms para voz/video

  @HiveField(8)
  int? size; // Tamaño en bytes

  @HiveField(9)
  DateTime timestamp;

  @HiveField(10)
  MessageStatus status;

  @HiveField(11)
  bool isOutgoing;

  @HiveField(12)
  String? eventId; // Event ID de Nostr

  @HiveField(13)
  int kind; // Kind de Nostr (4, 40, etc.)

  @HiveField(14)
  bool isDeleted;

  @HiveField(15)
  String? replyToMessageId;

  Message({
    required this.id,
    required this.chatId,
    required this.senderNpub,
    required this.type,
    this.content,
    this.mediaUrl,
    this.mediaThumbnail,
    this.duration,
    this.size,
    required this.timestamp,
    this.status = MessageStatus.sending,
    required this.isOutgoing,
    this.eventId,
    this.kind = 4,
    this.isDeleted = false,
    this.replyToMessageId,
  });

  Message copyWith({
    String? id,
    String? chatId,
    String? senderNpub,
    MessageType? type,
    String? content,
    String? mediaUrl,
    String? mediaThumbnail,
    int? duration,
    int? size,
    DateTime? timestamp,
    MessageStatus? status,
    bool? isOutgoing,
    String? eventId,
    int? kind,
    bool? isDeleted,
    String? replyToMessageId,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderNpub: senderNpub ?? this.senderNpub,
      type: type ?? this.type,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaThumbnail: mediaThumbnail ?? this.mediaThumbnail,
      duration: duration ?? this.duration,
      size: size ?? this.size,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      isOutgoing: isOutgoing ?? this.isOutgoing,
      eventId: eventId ?? this.eventId,
      kind: kind ?? this.kind,
      isDeleted: isDeleted ?? this.isDeleted,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderNpub': senderNpub,
      'type': type.index,
      'content': content,
      'mediaUrl': mediaUrl,
      'mediaThumbnail': mediaThumbnail,
      'duration': duration,
      'size': size,
      'timestamp': timestamp.toIso8601String(),
      'status': status.index,
      'isOutgoing': isOutgoing,
      'eventId': eventId,
      'kind': kind,
      'isDeleted': isDeleted,
      'replyToMessageId': replyToMessageId,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      senderNpub: json['senderNpub'] as String,
      type: MessageType.values[json['type'] as int],
      content: json['content'] as String?,
      mediaUrl: json['mediaUrl'] as String?,
      mediaThumbnail: json['mediaThumbnail'] as String?,
      duration: json['duration'] as int?,
      size: json['size'] as int?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: MessageStatus.values[json['status'] as int],
      isOutgoing: json['isOutgoing'] as bool,
      eventId: json['eventId'] as String?,
      kind: json['kind'] as int? ?? 4,
      isDeleted: json['isDeleted'] as bool? ?? false,
      replyToMessageId: json['replyToMessageId'] as String?,
    );
  }
}
