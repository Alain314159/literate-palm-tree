import 'dart:async';
import 'nostr_service.dart';
import '../models/message.dart';

/// BackgroundService - Mantiene conexión WebSocket en segundo plano
/// Las notificaciones push reales requieren Firebase o servicio nativo
class BackgroundService {
  static final BackgroundService _instance = BackgroundService._internal();
  factory BackgroundService() => _instance;
  BackgroundService._internal();

  Timer? _backgroundTimer;
  bool _isRunning = false;

  /// Initialize service
  Future<void> init() async {
    print('🔔 Background service initialized');
  }

  /// Start background listener - Mantiene WebSocket activo
  void startBackgroundListener() {
    if (_isRunning) return;
    
    _isRunning = true;
    
    // Heartbeat para mantener conexión WebSocket activa
    _backgroundTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _checkConnection();
    });
    
    print('🔔 Background listener started - WebSocket activo');
  }

  /// Stop background listener
  void stopBackgroundListener() {
    _backgroundTimer?.cancel();
    _isRunning = false;
    print('🔕 Background listener stopped');
  }

  /// Check connection status
  void _checkConnection() {
    if (!NostrService().isInitialized) return;
    
    if (!NostrService().isConnected) {
      print('🔄 Intentando reconectar...');
      // NostrService maneja reconexión automática
    } else {
      print('✅ WebSocket conectado - Escuchando mensajes...');
    }
  }

  /// Callback cuando llega mensaje nuevo
  void onNewMessage(Message message) {
    // En móvil, aquí se mostraría la notificación
    // En web, el navegador puede mostrar notificación si la pestaña está abierta
    print('📨 Mensaje recibido de ${message.senderNpub}: ${message.content}');
    
    // Notificar a la UI
    // La UI se encarga de mostrar el mensaje en el chat
  }
}
