import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// ConnectivityUtils - Detectar estado de conexión
/// Optimizado para reconexión en redes inestables (ETECSA)
class ConnectivityUtils {
  static final ConnectivityUtils _instance = ConnectivityUtils._internal();
  factory ConnectivityUtils() => _instance;
  ConnectivityUtils._internal();

  final Connectivity _connectivity = Connectivity();
  final StreamController<ConnectivityResult> _controller = 
      StreamController<ConnectivityResult>.broadcast();

  bool _isConnected = false;
  bool _isWifi = false;
  bool _isMobile = false;

  Stream<ConnectivityResult> get connectivityStream => _controller.stream;
  bool get isConnected => _isConnected;
  bool get isWifi => _isWifi;
  bool get isMobile => _isMobile;

  /// Start listening to connectivity changes
  void startListening() {
    _connectivity.onConnectivityChanged.listen((result) {
      _updateConnectivity(result.first);
      _controller.add(result.first);
    });
    
    // Check initial state
    _connectivity.checkConnectivity().then((result) {
      _updateConnectivity(result.first);
    });
  }

  void _updateConnectivity(ConnectivityResult result) {
    _isConnected = result != ConnectivityResult.none;
    _isWifi = result == ConnectivityResult.wifi;
    _isMobile = result == ConnectivityResult.mobile;
  }

  /// Check if connected to WiFi (better for media download)
  bool hasGoodConnection() {
    return _isWifi;
  }

  /// Check if can download media (based on settings)
  bool canDownloadMedia(bool ultraSaveMode, bool autoDownloadMedia) {
    if (ultraSaveMode) return false;
    if (!autoDownloadMedia) return false;
    return _isConnected;
  }

  /// Stop listening
  void stopListening() {
    _controller.close();
  }
}
