import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/nostr_service.dart';
import '../../../../core/services/app_state.dart';
import '../../../../core/models/keys.dart';
import '../../../main_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nsecController = TextEditingController();
  bool _isGenerating = false;
  bool _isImporting = false;
  String? _error;

  @override
  void dispose() {
    _nsecController.dispose();
    super.dispose();
  }

  Future<void> _generateNewAccount() async {
    setState(() {
      _isGenerating = true;
      _error = null;
    });

    try {
      final keys = NostrService().generateKeyPair();
      
      final newKeys = Keys(
        privateKey: keys['privateKey']!,
        publicKey: keys['publicKey']!,
        npub: keys['npub']!,
        nsec: keys['nsec'],
        createdAt: DateTime.now(),
        isImported: false,
      );

      await ref.read(appStateProvider).setAuthenticated(newKeys);

      if (!mounted) return;
      
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } catch (e) {
      setState(() {
        _error = 'Error generando cuenta: $e';
      });
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  Future<void> _importAccount() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isImporting = true;
      _error = null;
    });

    try {
      final success = await ref
          .read(appStateProvider)
          .importBackup(_nsecController.text.trim());

      if (!mounted) return;

      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      } else {
        setState(() {
          _error = 'nsec inválido. Verifica e intenta nuevamente.';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error importando cuenta: $e';
      });
    } finally {
      setState(() {
        _isImporting = false;
      });
    }
  }

  Future<void> _learnMore() async {
    const url = 'https://nostr.net';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                // Logo
                Icon(
                  Icons.pets,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Cerlita',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Mensajería descentralizada con Nostr',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                
                // Info card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¿Qué es Nostr?',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Nostr es un protocolo descentralizado para mensajería '
                          'resistente a la censura. Tus mensajes están cifrados '
                          'de extremo a extremo y tú eres dueño de tus claves.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: _learnMore,
                          child: const Text('Aprender más'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Import existing account
                Text(
                  'O importar cuenta existente',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nsecController,
                  decoration: const InputDecoration(
                    labelText: 'Ingresa tu nsec (clave privada)',
                    prefixIcon: Icon(Icons.key),
                    helperText: 'Comienza con nsec1...',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa tu clave privada';
                    }
                    if (!value.trim().startsWith('nsec1')) {
                      return 'Debe comenzar con nsec1';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _isImporting ? null : _importAccount,
                  icon: _isImporting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.login),
                  label: Text(_isImporting ? 'Importando...' : 'Importar Cuenta'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                
                if (_error != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _error!,
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                  ),
                ],

                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 32),

                // Create new account
                Text(
                  'Comenzar',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Crea una nueva cuenta con cifrado de extremo a extremo',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _isGenerating ? null : _generateNewAccount,
                  icon: _isGenerating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.person_add),
                  label: Text(_isGenerating ? 'Generando...' : 'Crear Nueva Cuenta'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '⚠️ Importante: Guarda tu clave privada (nsec) en un lugar seguro. '
                  'No hay recuperación de cuenta.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.orange.shade900,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
