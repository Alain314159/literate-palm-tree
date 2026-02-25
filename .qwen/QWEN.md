# QWEN.md - Configuración del Proyecto Cerlita

<!-- qwen-code:project-info: Cerlita -->

## 🎯 Preferencias de Desarrollo

### Plataforma Objetivo
- **Primero**: Android APK
- **Segundo**: Web (testing en Codespaces)
- **Tercero**: iOS/Linux (futuro)

### Estilo de Código
- **Arquitectura**: Feature-first
- **State Management**: Riverpod 2.x
- **Base de datos**: Hive (offline-first)
- **Error handling**: Try-catch con feedback al usuario

### Convenciones
- Nombres en español para UI, inglés para servicios
- Comments solo para lógica compleja
- Print statements para debug (remover en producción)

## 📡 Nostr Configuration

### Relays Primarios
- wss://relay.damus.io
- wss://nos.lol
- wss://relay.nostr.band

### Kinds Usados
- Kind 4: Mensajes directos (PRINCIPAL)
- Kind 0: Perfil de usuario
- Kind 7: Reacciones/read receipts

## 🔐 Security Notes

- NUNCA commitear claves privadas
- nsec solo en Hive (cifrado)
- Backup: Exportar nsec manualmente

## 🚀 Deployment

### GitHub Actions
- Build APK automático en push a main
- Deploy web a GitHub Pages
- Artifacts disponibles por 90 días

### Testing
- Web: `flutter run -d chrome`
- Android: GitHub Actions → Descargar APK

## 📱 Features Prioritarias

1. ✅ Mensajería 1-a-1 (kind 4)
2. ✅ Contactos (guardar npub)
3. ✅ Perfil (editar, copiar npub/nsec)
4. ✅ Temas (5 disponibles)
5. ✅ Background service
6. ⏳ Grupos (kind 40) - PENDIENTE
7. ⏳ Estados (kind 30315) - PENDIENTE
8. ⏳ Llamadas WebRTC - PENDIENTE

## 🐛 Known Issues

- Web: Notificaciones no funcionan (solo móvil)
- Web: WebSocket puede cerrar en background
- Android: Requiere build manual primera vez

## 💡 Tips para el Desarrollador

1. Siempre usar `force: true` en NostrService.init() al cambiar de usuario
2. Hive: Regenerar adapters con build_runner
3. Temas: Koalita y Cerdita-Koalita son dark mode
4. Mensajes: Se guardan local ANTES de enviar a relays

---

**Última actualización**: 2025-02-25
**Versión**: 1.0.0
**Estado**: ✅ Funcional (Mensajería básica completa)
