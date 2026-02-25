import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// MediaUtils - Utilidades para compresión y manejo de media
/// Optimizado para ETECSA: compresión agresiva (0.7 quality, max 1024px)
class MediaUtils {
  /// Compress image with ETECSA optimization
  /// - quality: 0.7 (balance calidad/tamaño)
  /// - maxWidth/maxHeight: 1024px (suficiente para móviles)
  static Future<File?> compressImage(File imageFile, {
    double quality = 0.7,
    int maxWidth = 1024,
    int maxHeight = 1024,
  }) async {
    try {
      final targetPath = (await getTemporaryDirectory()).path;
      final fileName = imageFile.path.split('/').last;
      
      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        '$targetPath/compressed_$fileName',
        quality: (quality * 100).toInt(),
        minWidth: maxWidth,
        minHeight: maxHeight,
        format: CompressFormat.jpeg,
      );
      
      return result != null ? File(result.path) : null;
    } catch (e) {
      print('Error compressing image: $e');
      return null;
    }
  }

  /// Compress video (wrapper para futura implementación)
  /// Nota: La compresión de video requiere ffmpeg_kit_flutter (pesado)
  /// Por ahora solo retornamos el archivo original
  static Future<File?> compressVideo(File videoFile, {
    double quality = 0.7,
  }) async {
    // TODO: Implementar compresión de video cuando sea necesario
    // Por ahora, retornamos el original
    return videoFile;
  }

  /// Get file size in bytes
  static Future<int> getFileSize(File file) async {
    return await file.length();
  }

  /// Get file size formatted (KB, MB, GB)
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Request storage permissions
  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (!status.isGranted) {
        final result = await Permission.storage.request();
        return result.isGranted;
      }
      return true;
    }
    return true; // iOS no requiere permiso explícito
  }

  /// Request camera permissions
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result.isGranted;
    }
    return true;
  }

  /// Request microphone permissions
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.status;
    if (!status.isGranted) {
      final result = await Permission.microphone.request();
      return result.isGranted;
    }
    return true;
  }

  /// Request notification permissions
  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.status;
    if (!status.isGranted) {
      final result = await Permission.notification.request();
      return result.isGranted;
    }
    return true;
  }

  /// Delete file
  static Future<void> deleteFile(File file) async {
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Copy file to app directory
  static Future<File> copyFileToAppDir(File file, String fileName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newPath = '${appDir.path}/$fileName';
    return await file.copy(newPath);
  }
}
