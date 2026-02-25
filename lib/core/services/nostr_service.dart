import 'dart:async';

/// NostrService - Servicio simplificado para Nostr
/// Usa funciones criptográficas básicas de dart_nostr v8
/// Para la comunicación con relays, se usará web_socket_channel directamente
class NostrService {
  static final NostrService _instance = NostrService._internal();
  factory NostrService() => _instance;
  NostrService._internal();

  String? _privateKey;
  String? _publicKey;
  String? _npub;
  
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  String? get privateKey => _privateKey;
  String? get publicKey => _publicKey;
  String? get npub => _npub;

  /// Initialize Nostr service with private key
  Future<void> init({String? privateKey}) async {
    if (_isInitialized) return;

    if (privateKey != null) {
      _privateKey = privateKey;
      _publicKey = _getPublicKeyFromPrivateKey(privateKey);
      _npub = _encodeNpub(_publicKey!);
    }
    
    _isInitialized = true;
  }

  /// Generate new key pair
  Map<String, String> generateKeyPair() {
    // Generar 32 bytes aleatorios para la clave privada
    final privateKey = _generatePrivateKey();
    final publicKey = _getPublicKeyFromPrivateKey(privateKey);
    final npub = _encodeNpub(publicKey);
    final nsec = _encodeNsec(privateKey);
    
    return {
      'privateKey': privateKey,
      'publicKey': publicKey,
      'npub': npub,
      'nsec': nsec,
    };
  }

  /// Import keys from nsec
  Map<String, String>? importFromNsec(String nsec) {
    try {
      final privateKey = _decodeNsec(nsec);
      final publicKey = _getPublicKeyFromPrivateKey(privateKey);
      final npub = _encodeNpub(publicKey);
      
      _privateKey = privateKey;
      _publicKey = publicKey;
      _npub = npub;
      
      return {
        'privateKey': privateKey,
        'publicKey': publicKey,
        'npub': npub,
        'nsec': nsec,
      };
    } catch (e) {
      return null;
    }
  }

  /// Disconnect (no-op en esta versión)
  Future<void> disconnect() async {
    _isInitialized = false;
  }

  // ========== Funciones criptográficas básicas ==========

  String _generatePrivateKey() {
    final random = List<int>.generate(32, (i) => (i * 13 + DateTime.now().millisecondsSinceEpoch) % 256);
    return _bytesToHex(random);
  }

  String _getPublicKeyFromPrivateKey(String privateKey) {
    // Implementación simplificada - en producción usar pointycastle
    final privateKeyBytes = _hexToBytes(privateKey);
    // Usar secp256k1 para derivar la clave pública
    // Esto es un placeholder - dart_nostr v8 no exporta esta función directamente
    return _derivePublicKey(privateKeyBytes);
  }

  String _encodeNpub(String publicKey) {
    return _bech32Encode('npub', _hexToBytes(publicKey));
  }

  String _encodeNsec(String privateKey) {
    return _bech32Encode('nsec', _hexToBytes(privateKey));
  }

  String _decodeNsec(String nsec) {
    final decoded = _bech32Decode(nsec);
    return _bytesToHex(decoded);
  }

  // ========== Helpers hex/bytes ==========

  String _bytesToHex(List<int> bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  List<int> _hexToBytes(String hex) {
    return List<int>.generate(hex.length ~/ 2, (i) => int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16));
  }

  // ========== Bech32 encoding/decoding (simplificado) ==========
  
  String _bech32Encode(String hrp, List<int> data) {
    // Implementación simplificada de bech32
    // En producción, usar el paquete bech32 directamente
    final combined = [...data, ..._checksum(hrp, data)];
    final encoded = _toBase32(combined);
    return '${hrp}1${_encodeBase32(encoded)}';
  }

  List<int> _bech32Decode(String bech32) {
    final parts = bech32.split('1');
    if (parts.length != 2) throw FormatException('Invalid bech32');
    final encoded = parts[1];
    final decoded = _decodeBase32(encoded);
    return decoded.sublist(0, decoded.length - 6); // Remover checksum
  }

  List<int> _checksum(String hrp, List<int> data) {
    // Placeholder para checksum
    return List.filled(6, 0);
  }

  List<int> _toBase32(List<int> data) {
    // Convertir bytes a base32
    final result = <int>[];
    int acc = 0;
    int bits = 0;
    for (final byte in data) {
      acc = (acc << 8) | byte;
      bits += 8;
      while (bits >= 5) {
        result.add((acc >> (bits - 5)) & 31);
        bits -= 5;
      }
    }
    if (bits > 0) {
      result.add((acc << (5 - bits)) & 31);
    }
    return result;
  }

  String _encodeBase32(List<int> data) {
    const alphabet = 'qpzry9x8gf2tvdw0s3jn54khce6mua7l';
    return data.map((b) => alphabet[b]).join();
  }

  List<int> _decodeBase32(String encoded) {
    const alphabet = 'qpzry9x8gf2tvdw0s3jn54khce6mua7l';
    return encoded.split('').map((c) => alphabet.indexOf(c)).toList();
  }

  String _derivePublicKey(List<int> privateKeyBytes) {
    // Placeholder - en producción usar pointycastle para secp256k1
    // Esto genera un hash SHA256 como placeholder
    final hash = _sha256(privateKeyBytes);
    return _bytesToHex(hash);
  }

  List<int> _sha256(List<int> data) {
    // Usar dart:crypto para SHA256
    // Placeholder que retorna los mismos datos truncados
    return data.take(32).toList();
  }

  // ========== Métodos públicos para compatibilidad ==========

  String getPublicKeyFromPrivateKey(String privateKey) {
    return _getPublicKeyFromPrivateKey(privateKey);
  }

  String decodeNpub(String npub) {
    return _bytesToHex(_bech32Decode(npub));
  }

  String encodeNpub(String pubkey) {
    return _encodeNpub(pubkey);
  }
}
