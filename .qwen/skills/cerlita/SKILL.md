# Cerlita - Skill de Conocimiento Especializado

## 📱 Descripción del Proyecto
Cerlita es una app de mensajería descentralizada usando el protocolo Nostr, optimizada para conexiones lentas (ETECSA Cuba).

## 🏗️ Arquitectura

### Feature-First Structure
```
lib/
├── core/
│   ├── models/         # Message, Contact, Keys, Settings, Media, State
│   ├── services/       # NostrService, HiveService, AppState, BackgroundService
│   └── utils/          # MediaUtils, ConnectivityUtils
├── features/
│   ├── auth/           # Generar/Importar claves (nsec/npub)
│   ├── chat/           # Lista de chats + Chat detail
│   ├── contacts/       # CRUD contactos, bloqueo
│   └── settings/       # Temas, perfil, backup
└── main.dart
```

## 🔧 Stack Tecnológico

| Categoría | Paquete | Versión | Uso |
|-----------|---------|---------|-----|
| **Nostr** | web_socket_channel | ^2.4.0 | WebSocket a relays |
| **State** | flutter_riverpod | ^2.5.1 | Gestión de estado |
| **DB** | hive, hive_flutter | ^2.2.3 | Base de datos local |
| **UI** | flutter | 3.24.0 | Framework principal |

## 📡 Protocolo Nostr Implementado

### NIPs Soportados
- **NIP-01**: Eventos básicos, estructura de mensajes
- **NIP-44**: Cifrado de mensajes privados
- **NIP-19**: Formatos bech32 (npub, nsec)
- **NIP-04**: Mensajes directos (kind 4)

### Kinds de Eventos
| Kind | Uso | Descripción |
|------|-----|-------------|
| 0 | Profile | Metadata de usuario |
| 4 | DM | Mensajes directos cifrados |
| 7 | Reaction | Read receipts, reacciones |
| 40 | Group | Mensajes grupales |
| 30315 | State | Estados (24h expiration) |

### Relays Configurados
```dart
[
  'wss://relay.damus.io',
  'wss://nos.lol',
  'wss://relay.nostr.band',
  'wss://purplepag.es',
  'wss://relay.snort.social',
  'wss://eden.nostr.land',
]
```

## 🔐 Claves y Seguridad

### Formato de Claves
- **Privada**: 64 caracteres hex (o nsec en bech32)
- **Pública**: 64 caracteres hex (o npub en bech32)
- **Cifrado**: NIP-44 (AES-CBC con derivación HKDF)

### Flujo de Autenticación
1. Generar clave con `NostrService.generateKeyPair()`
2. Guardar en Hive (keysBox)
3. Inicializar NostrService con `init(privateKey, force: true)`
4. Conectar a relays y suscribirse a mensajes

## 📦 Hive Boxes

| Box | Tipo | Datos |
|-----|------|-------|
| `messages` | Message | Todos los mensajes |
| `contacts` | Contact | Contactos agregados |
| `keys` | Keys | Claves del usuario (índice 0) |
| `settings` | Settings | Configuración de app |
| `media` | Media | Metadata de archivos |
| `states` | State | Estados tipo WhatsApp |

## 🎨 Temas Disponibles

```dart
enum ThemeType {
  light,        // Blanco/Azul
  dark,         // #121212/Blanco
  cerdita,      // Rosa #FFD1DC/#FF69B4
  koalita,      // Gris oscuro/Verde #5F8575
  cerditaKoalita, // Rosa/Gris oscuro
}
```

## 🚀 Comandos Comunes

### Desarrollo
```bash
flutter pub get
flutter run -d chrome
flutter analyze
```

### Build
```bash
flutter build web --release
flutter build apk --release
flutter build apk --split-per-abi
```

### Code Generation
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## ⚠️ Problemas Comunes y Soluciones

### "No hay claves inicializadas"
```dart
// SOLUCIÓN: Usar force=true en init()
await NostrService().init(privateKey: key, force: true);
```

### WebSocket no conecta
```dart
// VERIFICAR: 
- privateKey.length == 64
- npub comienza con "npub1"
- Relays están disponibles
```

### Hive adapter no registrado
```bash
# SOLUCIÓN: Regenerar adapters
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📝 Patrones de Código Preferidos

### 1. Offline-First
```dart
// Siempre guardar local primero
await messagesBox.put(message.id, message);
// Luego sincronizar
await NostrService().sendMessage(...);
```

### 2. Error Handling
```dart
try {
  await NostrService().sendMessage(...);
} catch (e) {
  // Mostrar error al usuario
  ScaffoldMessenger.of(context).showSnackBar(...);
}
```

### 3. State Management con Riverpod
```dart
final appState = ref.watch(appStateProvider);
final settings = appState.settings;
```

## 🔧 Configuración del Entorno

### GitHub Codespaces
- 8GB RAM disponible
- 32GB almacenamiento
- Flutter 3.24.0 instalado en /opt/flutter
- Android SDK en /opt/android-sdk

### Build para Android
- Usar GitHub Actions para APK
- No compilar localmente (lento en Codespaces)
- Probar con `flutter run -d chrome`

---

## 🎯 Objetivos de Optimización ETECSA

1. **Compresión**: Imágenes a 0.7 quality, max 1024px
2. **No auto-download**: Media solo con WiFi o permiso
3. **Ultra Save Mode**: Reduce sync a cada 30s
4. **Offline-first**: Todo se guarda local primero
5. **Reconexión**: Backoff exponencial (1s, 2s, 4s, 8s...)
