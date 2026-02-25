import 'package:hive/hive.dart';

part 'settings.g.dart';

enum ThemeType {
  light,
  dark,
  cerdita,
  koalita,
  cerditaKoalita,
}

@HiveType(typeId: 3)
class Settings extends HiveObject {
  @HiveField(0)
  String userNpub;

  @HiveField(1)
  ThemeType theme;

  @HiveField(2)
  bool ultraSaveMode; // Modo ultra ahorro de datos

  @HiveField(3)
  bool autoDownloadMedia; // Auto descargar media

  @HiveField(4)
  double imageQuality; // Calidad de compresión (0.7 por defecto)

  @HiveField(5)
  int maxImageSize; // Tamaño máximo en px (1024 por defecto)

  @HiveField(6)
  bool showReadReceipts; // Mostrar confirmación de lectura

  @HiveField(7)
  bool showTypingIndicators; // Mostrar "escribiendo..."

  @HiveField(8)
  List<String> defaultRelays; // Relays por defecto

  @HiveField(9)
  bool notificationsEnabled;

  @HiveField(10)
  bool soundEnabled;

  @HiveField(11)
  bool vibrationEnabled;

  @HiveField(12)
  String? languageCode; // Código de idioma (es, en, etc.)

  @HiveField(13)
  int messageRetentionDays; // Días para retener mensajes (30 por defecto)

  @HiveField(14)
  bool hidePreview; // Ocultar previsualización en notificaciones

  @HiveField(15)
  bool useFakeProfile; // Usar perfil falso para privacidad

  Settings({
    required this.userNpub,
    this.theme = ThemeType.dark,
    this.ultraSaveMode = false,
    this.autoDownloadMedia = true,
    this.imageQuality = 0.7,
    this.maxImageSize = 1024,
    this.showReadReceipts = true,
    this.showTypingIndicators = true,
    this.defaultRelays = const [
      'wss://relay.damus.io',
      'wss://nos.lol',
      'wss://relay.nostr.band',
      'wss://purplepag.es',
    ],
    this.notificationsEnabled = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.languageCode = 'es',
    this.messageRetentionDays = 30,
    this.hidePreview = false,
    this.useFakeProfile = false,
  });

  Settings copyWith({
    String? userNpub,
    ThemeType? theme,
    bool? ultraSaveMode,
    bool? autoDownloadMedia,
    double? imageQuality,
    int? maxImageSize,
    bool? showReadReceipts,
    bool? showTypingIndicators,
    List<String>? defaultRelays,
    bool? notificationsEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    String? languageCode,
    int? messageRetentionDays,
    bool? hidePreview,
    bool? useFakeProfile,
  }) {
    return Settings(
      userNpub: userNpub ?? this.userNpub,
      theme: theme ?? this.theme,
      ultraSaveMode: ultraSaveMode ?? this.ultraSaveMode,
      autoDownloadMedia: autoDownloadMedia ?? this.autoDownloadMedia,
      imageQuality: imageQuality ?? this.imageQuality,
      maxImageSize: maxImageSize ?? this.maxImageSize,
      showReadReceipts: showReadReceipts ?? this.showReadReceipts,
      showTypingIndicators: showTypingIndicators ?? this.showTypingIndicators,
      defaultRelays: defaultRelays ?? this.defaultRelays,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      languageCode: languageCode ?? this.languageCode,
      messageRetentionDays: messageRetentionDays ?? this.messageRetentionDays,
      hidePreview: hidePreview ?? this.hidePreview,
      useFakeProfile: useFakeProfile ?? this.useFakeProfile,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userNpub': userNpub,
      'theme': theme.index,
      'ultraSaveMode': ultraSaveMode,
      'autoDownloadMedia': autoDownloadMedia,
      'imageQuality': imageQuality,
      'maxImageSize': maxImageSize,
      'showReadReceipts': showReadReceipts,
      'showTypingIndicators': showTypingIndicators,
      'defaultRelays': defaultRelays,
      'notificationsEnabled': notificationsEnabled,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'languageCode': languageCode,
      'messageRetentionDays': messageRetentionDays,
      'hidePreview': hidePreview,
      'useFakeProfile': useFakeProfile,
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      userNpub: json['userNpub'] as String,
      theme: ThemeType.values[json['theme'] as int? ?? 1],
      ultraSaveMode: json['ultraSaveMode'] as bool? ?? false,
      autoDownloadMedia: json['autoDownloadMedia'] as bool? ?? true,
      imageQuality: (json['imageQuality'] as num?)?.toDouble() ?? 0.7,
      maxImageSize: json['maxImageSize'] as int? ?? 1024,
      showReadReceipts: json['showReadReceipts'] as bool? ?? true,
      showTypingIndicators: json['showTypingIndicators'] as bool? ?? true,
      defaultRelays: (json['defaultRelays'] as List<dynamic>?)?.cast<String>() ?? [
        'wss://relay.damus.io',
        'wss://nos.lol',
        'wss://relay.nostr.band',
        'wss://purplepag.es',
      ],
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
      languageCode: json['languageCode'] as String? ?? 'es',
      messageRetentionDays: json['messageRetentionDays'] as int? ?? 30,
      hidePreview: json['hidePreview'] as bool? ?? false,
      useFakeProfile: json['useFakeProfile'] as bool? ?? false,
    );
  }
}
