import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/app_state.dart';
import '../../../../core/models/settings.dart';
import '../../../theme/theme_data.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final settings = appState.settings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    appState.userNpub.substring(0, 12) + '...',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Copiar npub
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copiar npub'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Theme section
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Tema',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ...ThemeType.values.map((theme) => ListTile(
                      leading: _getThemeIcon(theme),
                      title: Text(_getThemeName(theme)),
                      trailing: settings?.theme == theme
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      onTap: () {
                        appState.updateSettings(
                          settings!.copyWith(theme: theme),
                        );
                      },
                    )),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Privacy & Data section
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Privacidad y Datos',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SwitchListTile(
                  title: const Text('Modo Ultra Ahorro'),
                  subtitle: const Text('Desactiva auto-download y reduce sync'),
                  value: settings?.ultraSaveMode ?? false,
                  onChanged: (value) {
                    appState.updateSettings(
                      settings!.copyWith(ultraSaveMode: value),
                    );
                  },
                ),
                SwitchListTile(
                  title: const Text('Auto-download Media'),
                  subtitle: const Text('Descargar media automáticamente'),
                  value: settings?.autoDownloadMedia ?? true,
                  onChanged: (value) {
                    appState.updateSettings(
                      settings!.copyWith(autoDownloadMedia: value),
                    );
                  },
                ),
                SwitchListTile(
                  title: const Text('Confirmación de Lectura'),
                  value: settings?.showReadReceipts ?? true,
                  onChanged: (value) {
                    appState.updateSettings(
                      settings!.copyWith(showReadReceipts: value),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Backup section
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Backup',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.backup),
                  title: const Text('Exportar Clave Privada'),
                  subtitle: const Text('Guarda tu nsec en un lugar seguro'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showBackupDialog(context, appState);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Logout
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                _showLogoutDialog(context, appState);
              },
            ),
          ),
          const SizedBox(height: 32),

          // App info
          Center(
            child: Text(
              'Cerlita v1.0.0',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Mensajería descentralizada con Nostr',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Icon _getThemeIcon(ThemeType theme) {
    switch (theme) {
      case ThemeType.light:
        return const Icon(Icons.light_mode, color: Colors.orange);
      case ThemeType.dark:
        return const Icon(Icons.dark_mode, color: Colors.blue);
      case ThemeType.cerdita:
        return const Icon(Icons.pets, color: Colors.pink);
      case ThemeType.koalita:
        return const Icon(Icons.eco, color: Colors.green);
      case ThemeType.cerditaKoalita:
        return const Icon(Icons.palette, color: Colors.purple);
      default:
        return const Icon(Icons.brightness_auto, color: Colors.grey);
    }
  }

  String _getThemeName(ThemeType theme) {
    switch (theme) {
      case ThemeType.light:
        return 'Claro';
      case ThemeType.dark:
        return 'Oscuro';
      case ThemeType.cerdita:
        return 'Cerdita';
      case ThemeType.koalita:
        return 'Koalita';
      case ThemeType.cerditaKoalita:
        return 'Cerdita y Koalita';
    }
  }

  void _showBackupDialog(BuildContext context, AppState appState) {
    final nsec = appState.exportBackup();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tu Clave Privada (nsec)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '⚠️ IMPORTANTE: Guarda esto en un lugar seguro. No hay recuperación de cuenta.',
              style: TextStyle(color: Colors.orange),
            ),
            const SizedBox(height: 16),
            SelectableText(
              nsec ?? '',
              style: const TextStyle(fontFamily: 'monospace'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Copiar al portapapeles
              Navigator.pop(context);
            },
            icon: const Icon(Icons.copy),
            label: const Text('Copiar'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text(
          '¿Estás seguro? Tendrás que ingresar tu clave privada para volver a entrar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              appState.logout();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }
}
