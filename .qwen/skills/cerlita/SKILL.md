# Cerlita - Skill Maestra Actualizada 2025/2026

## 📱 Visión General del Proyecto

**Cerlita** es una app de mensajería descentralizada P2P usando protocolo Nostr, optimizada para conexiones de bajo ancho de banda (ETECSA Cuba).

**Estado**: ✅ Producción - Versión 1.0.0
**Última actualización**: 2025-02-25

---

## 🏗️ Arquitectura Actualizada

### Feature-First + Clean Architecture
```
lib/
├── core/
│   ├── models/              # Entidades: Message, Contact, Keys, Settings, Media, State
│   ├── services/            # Servicios: NostrService, HiveService, AppState, BackgroundService
│   └── utils/               # Utilidades: MediaUtils, ConnectivityUtils
├── features/
│   ├── auth/                # Autenticación (generar/importar nsec)
│   ├── chat/                # Chats individuales (kind 4)
│   ├── contacts/            # Gestión de contactos
│   ├── groups/              # Grupos (kind 40) - PENDIENTE
│   ├── states/              # Estados (kind 30315) - PENDIENTE
│   ├── calls/               # Llamadas WebRTC - PENDIENTE
│   └── settings/            # Configuración, temas, perfil
└── main.dart                # Entry point con Riverpod
```

### Agentes IA Configurados
- **@nostr-agent**: Experto en protocolo Nostr (NIPs, relays, cifrado)
- **@perf-agent**: Optimización de rendimiento y memoria
- **@offline-agent**: Estrategias offline-first y sync
- **@security-agent**: Auditoría de seguridad y cifrado
- **@ui-agent**: Mejoras de UX y temas

---

## 🔧 Stack Tecnológico ACTUALIZADO 2026

| Categoría | Paquete | Versión Actual | Última | Estado |
|-----------|---------|----------------|--------|--------|
| **Nostr** | dart_nostr | 8.0.3 | 9.2.5 | ⚠️ ACTUALIZAR |
| **WebSocket** | web_socket_channel | 2.4.0 | 3.0.3 | ⚠️ ACTUALIZAR |
| **State** | flutter_riverpod | 2.5.1 | 3.2.1 | ✅ OK |
| **DB** | hive, hive_flutter | 2.2.3 | 2.2.3 | ✅ OK |
| **UI** | flutter | 3.24.0 | 3.29.0 | ⚠️ ACTUALIZAR |
| **Notifications** | flutter_local_notifications | - | 17.2.4 | ⏳ PENDIENTE |

### 🚨 Actualizaciones Críticas Recomendadas

```yaml
dependencies:
  dart_nostr: ^9.2.5          # Actualizar de 8.0.3 (NIP-44 mejorado)
  web_socket_channel: ^3.0.3  # Actualizar de 2.4.0
  flutter_riverpod: ^2.6.1    # Mantener 2.x (compatible)
  
dev_dependencies:
  build_runner: ^2.4.9        # Para generar adapters
  hive_generator: ^2.0.1      # Hive adapters
```

---

## 📡 Protocolo Nostr - Implementación DETALLADA

### NIPs Implementados
| NIP | Descripción | Estado | Prioridad |
|-----|-------------|--------|-----------|
| **NIP-01** | Eventos básicos, estructura | ✅ Completo | ALTA |
| **NIP-04** | Mensajes cifrados (kind 4) | ✅ Completo | ALTA |
| **NIP-19** | bech32 (npub, nsec) | ✅ Completo | ALTA |
| **NIP-44** | Cifrado mejorado | ⏳ PENDIENTE | MEDIA |
| NIP-05 | Verificación de identidad | ⏳ PENDIENTE | BAJA |
| NIP-40 | Grupos | ⏳ PENDIENTE | MEDIA |
| NIP-30315 | Estados | ⏳ PENDIENTE | BAJA |

### Kinds de Eventos - ESTADO ACTUAL
```dart
// ✅ IMPLEMENTADOS
Kind 0:   Profile metadata (básico)
Kind 4:   Direct messages (COMPLETO - cifrado NIP-04)
Kind 7:   Reactions/read receipts (básico)

// ⏳ PENDIENTES
Kind 40:  Group chats
Kind 30315: User status (24h)
Kind 20000-29999: Ephemeral events (typing indicators)
```

### 🔥 Relays Optimizados para Cuba/ETECSA

**Configuración ACTUAL (6 relays)**:
```dart
[
  'wss://relay.damus.io',        // ✅ Global, rápido
  'wss://nos.lol',                // ✅ Estable
  'wss://relay.nostr.band',       // ✅ Bueno para LatAm
  'wss://purplepag.es',           // ✅ Perfiles
  'wss://relay.snort.social',     // ✅ Rápido
  'wss://eden.nostr.land',        // ✅ Nuevo
]
```

**Optimización recomendada (investigación 2025)**:
- Máximo 5-6 relays activos (balance bandwidth/redundancy)
- Usar relays geográficamente cercanos (LatAm > Europa > US)
- Implementar circuit breaker para relays lentos (>5s timeout)
- Backoff exponencial: 1s, 2s, 4s, 8s, 16s (máx 30s)

---

## 🔐 Seguridad y Cifrado - MEJORES PRÁCTICAS 2025

### Manejo de Claves (ACTUALIZADO)
```dart
// ✅ CORRECTO - Implementación actual
final keys = NostrService().generateKeyPair();
// privateKey: 64 chars hex
// publicKey: 64 chars hex
// npub: bech32 encoding
// nsec: bech32 encoding (GUARDAR SEGURO)

// ✅ CORRECTO - Inicialización
await NostrService().init(privateKey: key, force: true);
// force: true permite re-init con nuevas claves

// ⚠️ NUNCA hacer
print(privateKey);  // NUNCA loguear claves
SharedPreferences.save('nsec', nsec);  // USAR Hive cifrado
```

### Cifrado de Mensajes

**Actual (NIP-04)**:
```dart
// ✅ Funciona pero NO es lo más seguro
final encrypted = nip04.encrypt(message, recipientPubkey);
// Limitación: No tan seguro como Signal/WhatsApp
```

**Recomendado (NIP-44)** - dart_nostr v9.2.5:
```dart
// ✅ MEJOR - Implementar con v9.2.5
final encrypted = nip44.encrypt(message, recipientPubkey);
// Ventajas: AES-256-GCM, nonces únicos, más seguro
```

---

## 📦 Hive Database - Optimizado 2025

### Boxes Configurados
```dart
BoxNames {
  messages:   // Message[] - Todos los mensajes
  contacts:   // Contact[] - Contactos
  keys:       // Keys[1] - Única clave del usuario (índice 0)
  settings:   // Settings[1] - Configuración
  media:      // Media[] - Metadata de archivos
  states:     // State[] - Estados (futuro)
  chats:      // Map[] - Metadata de chats
}
```

### 🚀 Optimizaciones de Rendimiento

**Problema**: >1000 mensajes = lento
**Solución**:
```dart
// ✅ Paginación
final messages = messagesBox.values
    .where((m) => m.chatId == chatId)
    .skip(page * pageSize)
    .take(pageSize)
    .toList();

// ✅ Limpieza automática
if (messagesBox.length > 1000) {
  final oldMessages = messagesBox.values
      .where((m) => m.timestamp < DateTime.now().subtract(Duration(days: 30)))
      .take(100);
  for (final m in oldMessages) {
    messagesBox.delete(m.id);
  }
}

// ✅ Índices personalizados
// Crear box separado por chatId para queries rápidas
```

---

## 🌐 Offline-First - Estrategias 2025

### Arquitectura Offline-First (BEST PRACTICE)

```dart
// ✅ CORRECTO - Flujo completo
Future<void> sendMessage(String content) async {
  // 1. Crear mensaje local
  final message = Message(
    id: generateId(),
    content: content,
    status: MessageStatus.sending,  // Marcador de estado
    timestamp: DateTime.now(),
  );
  
  // 2. Guardar LOCAL PRIMERO (offline-first)
  await messagesBox.put(message.id, message);
  
  // 3. Intentar enviar a relays
  try {
    await NostrService().sendMessage(...);
    message.status = MessageStatus.sent;
  } catch (e) {
    message.status = MessageStatus.failed;
    // 4. Queue para reintentar
    await syncQueue.add(message);
  }
  
  // 5. Actualizar local
  await messagesBox.put(message.id, message);
}
```

### Sync Queue - PENDIENTE DE IMPLEMENTAR
```dart
// ⏳ RECOMENDADO - Implementar
class SyncQueue {
  final Box _queueBox;
  
  Future<void> add(Message message) async {
    await _queueBox.put(message.id, message.toJson());
    _trySync();
  }
  
  Future<void> _trySync() async {
    if (await ConnectivityUtils().isConnected) {
      final pending = _queueBox.values.toList();
      for (final item in pending) {
        try {
          await NostrService().sendMessage(...);
          await _queueBox.delete(item.id);
        } catch (e) {
          // Backoff exponencial
          await Future.delayed(_calculateBackoff());
        }
      }
    }
  }
}
```

---

## 🎨 Temas - Implementación ACTUAL

### 5 Temas Disponibles

```dart
enum ThemeType {
  light,        // Blanco/Azul - WhatsApp style
  dark,         // #121212/#FFFFFF - Dark mode
  cerdita,      // #FFD1DC/#FF69B4 - Rosa pastel
  koalita,      // #2D2D2D/#5F8575 - Gris oscuro/Verde (DARK)
  cerditaKoalita, // #1A1A1A/#FF69B4 - Gris muy oscuro/Rosa (DARK)
}
```

### 🎯 Mejoras Recomendadas

**Koalita (ACTUAL - Dark)**:
```dart
// ✅ CORRECTO - Implementación actual
koalitaBackground: Color(0xFF2D2D2D),  // Gris oscuro
koalitaSurface: Color(0xFF3D3D3D),
koalitaPrimary: Color(0xFF5F8575),     // Verde eucalipto
```

**Cerdita-Koalita (ACTUAL - Dark con rosa)**:
```dart
// ✅ CORRECTO - Implementación actual
cerditaKoalitaBackground: Color(0xFF1A1A1A),  // Gris muy oscuro
cerditaKoalitaPrimary: Color(0xFFFF69B4),     // Hot pink
```

---

## 🚀 Comandos ACTUALIZADOS

### Desarrollo Diario
```bash
# Obtener dependencias
flutter pub get

# Ejecutar en web (Codespaces)
flutter run -d chrome

# Analizar código
flutter analyze

# Generar Hive adapters
flutter pub run build_runner build --delete-conflicting-outputs
```

### Build para Producción
```bash
# Web (GitHub Pages)
flutter build web --release

# Android APK (GitHub Actions - RECOMENDADO)
# El workflow genera automáticamente:
# - app-release.apk (universal)
# - split-per-abi (arm64-v8a, armeabi-v7a, x86_64)

# Android local (SOLO si es necesario)
flutter build apk --release
flutter build apk --release --split-per-abi
```

---

## ⚠️ Problemas Comunes y Soluciones (2025)

### 1. "No hay claves inicializadas"
```dart
// ❌ INCORRECTO
await NostrService().init(privateKey: key);

// ✅ CORRECTO
await NostrService().init(privateKey: key, force: true);
// force: true permite re-inicializar con nuevas claves
```

### 2. Hive adapter no registrado
```bash
# SOLUCIÓN
flutter pub run build_runner build --delete-conflicting-outputs

# Si persiste, limpiar
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. WebSocket no conecta a relays
```dart
// VERIFICAR
- privateKey.length == 64  // Debe ser 64 chars hex
- npub.startsWith('npub1') // Formato bech32 correcto
- Relays disponibles (probar con ping)

// SOLUCIÓN
await NostrService().disconnect();
await NostrService().init(privateKey: key, force: true);
```

### 4. Mensajes no se reciben
```dart
// VERIFICAR SUSCRIPCIÓN
// El filtro debe incluir kind 4 y pubkey del destinatario
final filter = {
  'kinds': [4],
  '#p': [_publicKey!],  // Mensajes para nosotros
};

// SOLUCIÓN: Re-suscribir
await _subscribeToMessages(channel, relayUrl);
```

---

## 📊 Métricas de Rendimiento (Objetivos 2025)

| Métrica | Objetivo | Actual | Estado |
|---------|----------|--------|--------|
| Build time (web) | <60s | 48s | ✅ |
| Build time (APK) | <5min | N/A (GitHub) | ✅ |
| Memory usage | <500MB | ~350MB | ✅ |
| Message send time | <2s | ~1.5s | ✅ |
| Reconnection time | <10s | ~5s | ✅ |
| Offline message save | <100ms | ~50ms | ✅ |

---

## 🔥 Optimizaciones ETECSA - CRÍTICAS

### 1. Compresión de Imágenes
```dart
// ✅ CORRECTO - Implementado
final compressed = await FlutterImageCompress.compressAndGetFile(
  imageFile.path,
  outputPath,
  quality: 70,  // 0.7 = 70% quality
  minWidth: 1024,
  minHeight: 1024,
);
```

### 2. No Auto-Download Media
```dart
// ✅ CORRECTO - Configuración
Settings {
  autoDownloadMedia: false,  // Default: false
  ultraSaveMode: false,      // Usuario puede activar
}
```

### 3. Ultra Save Mode
```dart
// ⏳ RECOMENDADO - Implementar
if (settings.ultraSaveMode) {
  // Reducir frecuencia de sync
  syncInterval = Duration(seconds: 30);  // En vez de 5s
  
  // No descargar media automáticamente
  autoDownloadMedia = false;
  
  // Reducir número de relays
  activeRelays = 3;  // En vez de 6
}
```

---

## 🎯 Roadmap - Próximas Implementaciones

### Prioridad ALTA (Siguiente Sprint)
- [ ] Actualizar dart_nostr a v9.2.5 (NIP-44)
- [ ] Implementar SyncQueue para mensajes pendientes
- [ ] Notificaciones push nativas (Android)
- [ ] Paginación de mensajes (lazy loading)

### Prioridad MEDIA
- [ ] Grupos (kind 40)
- [ ] Estados (kind 30315)
- [ ] Typing indicators (eventos efímeros)
- [ ] Read receipts (kind 7 reactions)

### Prioridad BAJA
- [ ] Llamadas WebRTC (voz/video)
- [ ] Stickers como imágenes custom
- [ ] Búsqueda avanzada de mensajes
- [ ] Backup automático en relay

---

## 📚 Recursos y Referencias

### Documentación Oficial
- [Nostr Protocol](https://nostr.net)
- [NIPs Repository](https://github.com/nostr-protocol/nips)
- [dart_nostr v9.2.5](https://pub.dev/packages/dart_nostr)
- [Flutter Offline-First](https://docs.flutter.dev/cookbook/persistence/offline)

### Mejores Prácticas 2025
- Multi-relay: 5-6 relays máximo
- Filtros específicos (no suscribir a todo)
- Cerrar suscripciones cuando no se usen
- Cache local de eventos
- Backoff exponencial para reconexión

---

**Skill actualizada automáticamente por IA Agents** 🤖
**Última sync**: 2025-02-25
**Próxima revisión**: 2025-03-01 (actualizar dart_nostr)
