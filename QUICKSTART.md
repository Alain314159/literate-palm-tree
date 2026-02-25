# 📋 Comandos Rápidos - Flutter App

## Verificar el entorno
```bash
flutter doctor -v
```

## Desarrollo diario
```bash
flutter pub get          # Instalar dependencias
flutter run              # Ejecutar en Linux desktop
flutter analyze          # Analizar código
```

## Build APK
```bash
flutter build apk --release              # APK universal
flutter build apk --split-per-abi        # APKs por arquitectura (más pequeño)
```

## Subir a GitHub
```bash
git add .
git commit -m "Descripción del cambio"
git push
```

## Variables de entorno (ya configuradas)
- `FLUTTER_ROOT=/opt/flutter`
- `ANDROID_HOME=/opt/android-sdk`
- PATH incluye Flutter y Android SDK

## Ubicaciones importantes
- **Flutter SDK**: `/opt/flutter`
- **Android SDK**: `/opt/android-sdk`
- **Proyecto**: `/workspaces/literate-palm-tree`
- **APK output**: `build/app/outputs/flutter-apk/`

---
✅ **Entorno listo para desarrollar**
