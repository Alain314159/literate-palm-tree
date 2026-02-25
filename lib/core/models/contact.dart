import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 1)
class Contact extends HiveObject {
  @HiveField(0)
  String npub; // Clave pública en formato npub

  @HiveField(1)
  String? customName; // Nombre personalizado (null si usa perfil Nostr)

  @HiveField(2)
  String? displayName; // Nombre a mostrar (customName o del perfil)

  @HiveField(3)
  String? about; // Descripción del perfil

  @HiveField(4)
  String? picture; // URL de la imagen de perfil

  @HiveField(5)
  String? nip05; // Identificador NIP-05 (ej: usuario@dominio.com)

  @HiveField(6)
  List<String> relays; // Relays donde se encuentra el contacto

  @HiveField(7)
  bool isBlocked; // Si está bloqueado

  @HiveField(8)
  DateTime? lastSeen; // Última vez en línea

  @HiveField(9)
  DateTime? lastMessageTime; // Hora del último mensaje

  @HiveField(10)
  int unreadCount; // Cantidad de mensajes no leídos

  @HiveField(11)
  bool isFavorite; // Si es favorito

  @HiveField(12)
  String? lastMessagePreview; // Preview del último mensaje

  @HiveField(13)
  bool hasUnreadMention; // Si tiene mención no leída

  @HiveField(14)
  DateTime createdAt; // Fecha de creación

  Contact({
    required this.npub,
    this.customName,
    this.displayName,
    this.about,
    this.picture,
    this.nip05,
    this.relays = const [],
    this.isBlocked = false,
    this.lastSeen,
    this.lastMessageTime,
    this.unreadCount = 0,
    this.isFavorite = false,
    this.lastMessagePreview,
    this.hasUnreadMention = false,
    required this.createdAt,
  });

  Contact copyWith({
    String? npub,
    String? customName,
    String? displayName,
    String? about,
    String? picture,
    String? nip05,
    List<String>? relays,
    bool? isBlocked,
    DateTime? lastSeen,
    DateTime? lastMessageTime,
    int? unreadCount,
    bool? isFavorite,
    String? lastMessagePreview,
    bool? hasUnreadMention,
    DateTime? createdAt,
  }) {
    return Contact(
      npub: npub ?? this.npub,
      customName: customName ?? this.customName,
      displayName: displayName ?? this.displayName,
      about: about ?? this.about,
      picture: picture ?? this.picture,
      nip05: nip05 ?? this.nip05,
      relays: relays ?? this.relays,
      isBlocked: isBlocked ?? this.isBlocked,
      lastSeen: lastSeen ?? this.lastSeen,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isFavorite: isFavorite ?? this.isFavorite,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      hasUnreadMention: hasUnreadMention ?? this.hasUnreadMention,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String getDisplayName() {
    return customName ?? displayName ?? npub.substring(0, 8);
  }

  Map<String, dynamic> toJson() {
    return {
      'npub': npub,
      'customName': customName,
      'displayName': displayName,
      'about': about,
      'picture': picture,
      'nip05': nip05,
      'relays': relays,
      'isBlocked': isBlocked,
      'lastSeen': lastSeen?.toIso8601String(),
      'lastMessageTime': lastMessageTime?.toIso8601String(),
      'unreadCount': unreadCount,
      'isFavorite': isFavorite,
      'lastMessagePreview': lastMessagePreview,
      'hasUnreadMention': hasUnreadMention,
    };
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      npub: json['npub'] as String,
      customName: json['customName'] as String?,
      displayName: json['displayName'] as String?,
      about: json['about'] as String?,
      picture: json['picture'] as String?,
      nip05: json['nip05'] as String?,
      relays: (json['relays'] as List<dynamic>?)?.cast<String>() ?? [],
      isBlocked: json['isBlocked'] as bool? ?? false,
      lastSeen: json['lastSeen'] != null
          ? DateTime.parse(json['lastSeen'] as String)
          : null,
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.parse(json['lastMessageTime'] as String)
          : null,
      unreadCount: json['unreadCount'] as int? ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
      lastMessagePreview: json['lastMessagePreview'] as String?,
      hasUnreadMention: json['hasUnreadMention'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }
}
