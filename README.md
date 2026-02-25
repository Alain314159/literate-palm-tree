# 🐷🐨 Cerlita - Mensajería Descentralizada con Nostr

**Cerlita** es una aplicación de mensajería descentralizada, cifrada de extremo a extremo, construida con Flutter y el protocolo Nostr. Optimizada para conexiones lentas (ETECSA) con modo ultra-ahorro de datos.

## 📱 Características

### Funcionalidades Principales
- ✅ **Mensajería privada** (NIP-01, Kind 4) con cifrado NIP-44
- ✅ **Grupos/Chats grupales** (Kind 40)
- ✅ **Estados tipo WhatsApp** (Kind 30315) - duran 24 horas
- ✅ **Llamadas voz/video P2P** con WebRTC (signaling via Nostr)
- ✅ **Mensajes de voz** - grabación y reproducción
- ✅ **Imágenes/videos comprimidos** - 0.7 quality, max 1024px
- ✅ **Stickers** como imágenes personalizadas
- ✅ **Read receipts** (Kind 7 reactions)
- ✅ **Typing indicators** (eventos efímeros)
- ✅ **Nombres personalizados** para contactos
- ✅ **Bloqueo de contactos**
- ✅ **Búsqueda** de mensajes y contactos
- ✅ **Backup de claves** - exportar/importar nsec

### Optimizaciones ETECSA
- 📶 **Ultra offline-first** - guarda local inmediato con Hive
- 📶 **Sincronización diferida** - solo cuando hay conexión
- 📶 **Reconexión con backoff** exponencial
- 📶 **Compresión agresiva** de imágenes/videos
- 📶 **Modo UltraSave** - desactiva auto-download y reduce checks
- 📶 **No auto-download media** - configurable

### 5 Temas Personalizados
1. **Claro** - Blanco/Azul (estilo WhatsApp)
2. **Oscuro** - #121212/Blanco (WhatsApp Dark)
3. **Cerdita** - Rosa pastel #FFD1DC/#FF69B4
4. **Koalita** - Gris ceniza/Verde eucalipto #5F8575
5. **Cerdita y Koalita** - Mezcla rosa/gris-verde

## 🏗️ Arquitectura

```
lib/
├── core/
│   ├── models/         # Message, Contact, Keys, Settings, Media, State
│   ├── services/       # HiveService, NostrService, AppState
│   └── utils/          # MediaUtils, ConnectivityUtils
├── features/
│   ├── auth/           # Generar/Importar claves
│   ├── contacts/       # CRUD contactos, bloqueo
│   ├── chat/           # Mensajes texto/voz/imagen/video
│   ├── groups/         # Chats grupales (kind 40)
│   ├── states/         # Estados (kind 30315)
│   ├── calls/          # Llamadas WebRTC
│   ├── settings/       # Configuración, backup, temas
│   └── theme/          # 5 temas personalizados
└── main.dart
```

## 🛠️ Stack Tecnológico

| Categoría | Paquete | Versión |
|-----------|---------|---------|
| **Nostr** | dart_nostr | ^8.0.3 |
| **State** | flutter_riverpod | ^2.5.1 |
| **DB** | hive, hive_flutter | ^2.2.3 |
| **WebRTC** | flutter_webrtc | ^0.13.0 |
| **Audio** | record, just_audio | ^5.1.0, ^0.9.38 |
| **Imágenes** | image_picker, flutter_image_compress | ^1.0.7, ^2.3.0 |
| **Permisos** | permission_handler | ^11.3.1 |
| **Conectividad** | connectivity_plus | ^6.0.3 |

## 🚀 Comenzar

### Prerrequisitos
- Flutter 3.24.0+
- Java 17+
- Android SDK 34

### Instalación en Codespaces
```bash
# Las dependencias ya están instaladas en este entorno
flutter pub get
```

### Ejecutar en modo web (desarrollo)
```bash
flutter run -d chrome
```

### Build APK (GitHub Actions)
El APK se genera automáticamente al hacer push a `main`:
1. Push → GitHub Actions → Build APK
2. Descarga el artifact desde la pestaña **Actions**

## 📡 Protocolo Nostr

### Kinds de Eventos
| Kind | Uso | Descripción |
|------|-----|-------------|
| 0 | Profile | Metadata de usuario |
| 4 | DM | Mensajes directos cifrados (NIP-44) |
| 7 | Reaction | Read receipts, reacciones |
| 40 | Group | Mensajes grupales |
| 30315 | State | Estados (24h expiration) |

### Relays por Defecto
```
wss://relay.damus.io
wss://nos.lol
wss://relay.nostr.band
wss://purplepag.es
```

## 🔐 Seguridad

- **Cifrado**: NIP-44 (AES-CBC con derivación de clave)
- **Claves**: Ed25519 (secp256k1 para compatibilidad)
- **Formato**: npub/nsec (NIP-19 bech32)
- **Almacenamiento**: Hive cifrado local

## 📦 Estructura de la DB (Hive)

### Boxes
- `messages` - Mensajes (id, chatId, sender, type, content, mediaUrl, timestamp, status)
- `contacts` - Contactos (npub, customName, isBlocked, lastSeen)
- `keys` - Claves del usuario (privateKey, publicKey, npub, nsec)
- `settings` - Configuración (theme, ultraSaveMode, autoDownload)
- `media` - Metadata de media (url, localPath, size, type)
- `states` - Estados (userNpub, content, mediaUrl, expiresAt)

## 🎨 Temas

```dart
enum ThemeType {
  light,        // Claro
  dark,         // Oscuro
  cerdita,      // Rosa
  koalita,      // Verde eucalipto
  cerditaKoalita, // Mezcla
}
```

## 📝 Comandos Útiles

```bash
# Desarrollo
flutter pub get
flutter run -d chrome
flutter analyze

# Build
flutter build apk --release
flutter build apk --split-per-abi

# Limpieza
flutter clean
flutter pub get
```

## 🔄 GitHub Actions

El workflow `.github/workflows/build-apk.yml`:
1. Checkout del código
2. Setup Java 17
3. Setup Flutter 3.24.0
4. `flutter pub get`
5. `flutter analyze`
6. `flutter build apk --release`
7. Upload del APK como artifact

## ⚠️ Notas Importantes

1. **Backup**: Guarda tu nsec en un lugar seguro. No hay recuperación de cuenta.
2. **Privacidad**: Los mensajes son P2P cifrados. Los relays solo ven eventos cifrados.
3. **Offline-first**: Los mensajes se guardan localmente primero, luego se sincronizan.
4. **Compresión**: Imágenes se comprimen a 70% quality, max 1024px para ahorrar datos.

## 📄 Licencia

MIT License - Ver LICENSE

## 🙏 Créditos

- Protocolo Nostr: https://nostr.net
- dart_nostr: https://pub.dev/packages/dart_nostr
- Flutter: https://flutter.dev

---

**Cerlita** 🐷🐨 - Mensajería descentralizada para todos.
