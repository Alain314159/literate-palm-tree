import 'package:hive/hive.dart';

part 'state.g.dart';

enum StateMediaType { image, video }

@HiveType(typeId: 5)
class State extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String userNpub;

  @HiveField(2)
  String? content; // Texto del estado

  @HiveField(3)
  String? mediaUrl; // URL de imagen/video del estado

  @HiveField(4)
  StateMediaType mediaType;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime expiresAt; // 24 horas después de createdAt

  @HiveField(7)
  List<String> viewedBy; // Lista de npubs que lo vieron

  @HiveField(8)
  int kind; // NIP-30315

  @HiveField(9)
  String? eventId; // Event ID de Nostr

  @HiveField(10)
  bool isMyState; // Si es mi estado

  State({
    required this.id,
    required this.userNpub,
    this.content,
    this.mediaUrl,
    this.mediaType = StateMediaType.image,
    required this.createdAt,
    required this.expiresAt,
    this.viewedBy = const [],
    this.kind = 30315,
    this.eventId,
    this.isMyState = false,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  State copyWith({
    String? id,
    String? userNpub,
    String? content,
    String? mediaUrl,
    StateMediaType? mediaType,
    DateTime? createdAt,
    DateTime? expiresAt,
    List<String>? viewedBy,
    int? kind,
    String? eventId,
    bool? isMyState,
  }) {
    return State(
      id: id ?? this.id,
      userNpub: userNpub ?? this.userNpub,
      content: content ?? this.content,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      viewedBy: viewedBy ?? this.viewedBy,
      kind: kind ?? this.kind,
      eventId: eventId ?? this.eventId,
      isMyState: isMyState ?? this.isMyState,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userNpub': userNpub,
      'content': content,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType.index,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'viewedBy': viewedBy,
      'kind': kind,
      'eventId': eventId,
      'isMyState': isMyState,
    };
  }

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id'] as String,
      userNpub: json['userNpub'] as String,
      content: json['content'] as String?,
      mediaUrl: json['mediaUrl'] as String?,
      mediaType: StateMediaType.values[json['mediaType'] as int],
      createdAt: DateTime.parse(json['createdAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      viewedBy: (json['viewedBy'] as List<dynamic>?)?.cast<String>() ?? [],
      kind: json['kind'] as int? ?? 30315,
      eventId: json['eventId'] as String?,
      isMyState: json['isMyState'] as bool? ?? false,
    );
  }
}
