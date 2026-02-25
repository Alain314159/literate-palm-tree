import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/models.dart';
import '../../core/services/services.dart';

/// AppState - Estado global de la aplicación
/// Maneja: autenticación, settings, conectividad, UI state
class AppState extends ChangeNotifier {
  static AppState? _instance;
  static AppState get instance {
    _instance ??= AppState._();
    return _instance!;
  }
  AppState._();

  // Authentication state
  Keys? _currentUserKeys;
  bool _isAuthenticated = false;
  bool _isInitializing = true;

  // Settings
  Settings? _settings;

  // Connectivity
  bool _isOnline = false;
  bool _isSyncing = false;

  // UI state
  int _currentTabIndex = 0;
  String? _activeChatId;
  bool _showEmojiPicker = false;

  // Getters
  Keys? get currentUserKeys => _currentUserKeys;
  bool get isAuthenticated => _isAuthenticated;
  bool get isInitializing => _isInitializing;
  Settings? get settings => _settings;
  bool get isOnline => _isOnline;
  bool get isSyncing => _isSyncing;
  int get currentTabIndex => _currentTabIndex;
  String? get activeChatId => _activeChatId;
  bool get showEmojiPicker => _showEmojiPicker;

  String get userNpub => _currentUserKeys?.npub ?? '';
  String get userPublicKey => _currentUserKeys?.publicKey ?? '';
  String get userPrivateKey => _currentUserKeys?.privateKey ?? '';

  ThemeType get theme => _settings?.theme ?? ThemeType.dark;
  bool get ultraSaveMode => _settings?.ultraSaveMode ?? false;
  bool get autoDownloadMedia => _settings?.autoDownloadMedia ?? true;

  /// Initialize app state from Hive
  Future<void> init() async {
    try {
      // Load keys
      if (keysBox.isNotEmpty) {
        _currentUserKeys = keysBox.getAt(0);
        _isAuthenticated = _currentUserKeys != null;
        
        // Initialize Nostr with loaded keys
        if (_currentUserKeys != null) {
          await NostrService().init(privateKey: _currentUserKeys!.privateKey, force: true);
        }
      }

      // Load settings
      if (settingsBox.isNotEmpty) {
        _settings = settingsBox.getAt(0);
      } else if (_currentUserKeys != null) {
        // Create default settings
        _settings = Settings(userNpub: _currentUserKeys!.npub);
        await settingsBox.put(0, _settings!);
      }
    } catch (e) {
      print('Error initializing AppState: $e');
    } finally {
      _isInitializing = false;
      notifyListeners();
    }
  }

  /// Set authentication with keys
  Future<void> setAuthenticated(Keys keys) async {
    _currentUserKeys = keys;
    _isAuthenticated = true;
    
    // Save to Hive
    await keysBox.put(0, keys);
    
    // Create default settings if not exists
    if (_settings == null) {
      _settings = Settings(userNpub: keys.npub);
      await settingsBox.put(0, _settings!);
    }
    
    // CRITICAL: Initialize NostrService with the new keys (force re-init)
    await NostrService().init(privateKey: keys.privateKey, force: true);
    
    notifyListeners();
  }

  /// Logout
  Future<void> logout() async {
    await NostrService().disconnect();
    _currentUserKeys = null;
    _isAuthenticated = false;
    _settings = null;
    
    await keysBox.clear();
    await settingsBox.clear();
    
    notifyListeners();
  }

  /// Update settings
  Future<void> updateSettings(Settings newSettings) async {
    _settings = newSettings;
    await settingsBox.put(0, newSettings);
    notifyListeners();
  }

  /// Update connectivity status
  void setOnline(bool online) {
    _isOnline = online;
    notifyListeners();
  }

  /// Set syncing state
  void setSyncing(bool syncing) {
    _isSyncing = syncing;
    notifyListeners();
  }

  /// Set current tab index
  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  /// Set active chat
  void setActiveChat(String? chatId) {
    _activeChatId = chatId;
    notifyListeners();
  }

  /// Toggle emoji picker
  void toggleEmojiPicker({bool? show}) {
    _showEmojiPicker = show ?? !_showEmojiPicker;
    notifyListeners();
  }

  /// Import backup (keys)
  Future<bool> importBackup(String nsec) async {
    final result = NostrService().importFromNsec(nsec);
    if (result != null) {
      final keys = Keys(
        privateKey: result['privateKey']!,
        publicKey: result['publicKey']!,
        npub: result['npub']!,
        nsec: result['nsec'],
        createdAt: DateTime.now(),
        isImported: true,
      );
      await setAuthenticated(keys);
      return true;
    }
    return false;
  }

  /// Export backup (nsec)
  String? exportBackup() {
    return _currentUserKeys?.nsec;
  }
}

/// Riverpod provider for AppState
final appStateProvider = ChangeNotifierProvider<AppState>((ref) {
  return AppState.instance;
});

/// Provider for authentication state
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).isAuthenticated;
});

/// Provider for current user npub
final userNpubProvider = Provider<String>((ref) {
  return ref.watch(appStateProvider).userNpub;
});

/// Provider for theme
final themeProvider = Provider<ThemeType>((ref) {
  return ref.watch(appStateProvider).theme;
});

/// Provider for ultra save mode
final ultraSaveModeProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).ultraSaveMode;
});
