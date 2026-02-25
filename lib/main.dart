import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/services/hive_service.dart';
import 'core/services/app_state.dart';
import 'core/services/background_service.dart';
import 'core/services/nostr_service.dart';
import 'core/utils/connectivity_utils.dart';
import 'features/theme/theme_data.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/auth_screen.dart';
import 'features/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    await Hive.initFlutter();
    await initHive();

    // Initialize AppState
    await AppState.instance.init();
    
    // Initialize background service for notifications
    await BackgroundService().init();
    
    // Start background listener
    BackgroundService().startBackgroundListener();
    
    // Setup message callback
    NostrService().setOnNewMessage((message) {
      if (!message.isOutgoing) {
        BackgroundService().onNewMessage(message);
      }
    });
  } catch (e) {
    print('Error initializing: $e');
  }

  // Start connectivity listener
  ConnectivityUtils().startListening();

  runApp(
    const ProviderScope(
      child: CerlitaApp(),
    ),
  );
}

class CerlitaApp extends ConsumerWidget {
  const CerlitaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final themeType = appState.theme;
    
    return MaterialApp(
      title: 'Cerlita',
      debugShowCheckedModeBanner: false,
      theme: CerlitaTheme.getTheme(themeType),
      home: _buildHome(appState),
    );
  }

  Widget _buildHome(AppState appState) {
    if (appState.isInitializing) {
      return const SplashScreen();
    }
    
    if (!appState.isAuthenticated) {
      return const AuthScreen();
    }
    
    return const MainScreen();
  }
}
