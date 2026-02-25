import 'package:hive/hive.dart';

part 'keys.g.dart';

@HiveType(typeId: 2)
class Keys extends HiveObject {
  @HiveField(0)
  String privateKey; // Clave privada en hex

  @HiveField(1)
  String publicKey; // Clave pública en hex

  @HiveField(2)
  String npub; // Clave pública en formato npub (NIP-19)

  @HiveField(3)
  String? nsec; // Clave privada en formato nsec (NIP-19)

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  bool isImported; // Si fue importada o generada

  @HiveField(6)
  String? backupHint; // Pista para el backup (opcional)

  Keys({
    required this.privateKey,
    required this.publicKey,
    required this.npub,
    this.nsec,
    required this.createdAt,
    this.isImported = false,
    this.backupHint,
  });

  Map<String, dynamic> toJson() {
    return {
      'privateKey': privateKey,
      'publicKey': publicKey,
      'npub': npub,
      'nsec': nsec,
      'createdAt': createdAt.toIso8601String(),
      'isImported': isImported,
      'backupHint': backupHint,
    };
  }

  factory Keys.fromJson(Map<String, dynamic> json) {
    return Keys(
      privateKey: json['privateKey'] as String,
      publicKey: json['publicKey'] as String,
      npub: json['npub'] as String,
      nsec: json['nsec'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isImported: json['isImported'] as bool? ?? false,
      backupHint: json['backupHint'] as String?,
    );
  }
}
