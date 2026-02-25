import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/app_state.dart';
import '../../../../core/services/nostr_service.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _nip05Controller = TextEditingController();
  bool _isLoading = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Cargar datos actuales (placeholder - luego cargar de Nostr)
    _nameController.text = ''; // TODO: Cargar desde perfil Nostr
    _aboutController.text = '';
    _nip05Controller.text = '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    _nip05Controller.dispose();
    super.dispose();
  }

  void _copyNsec() {
    final nsec = NostrService().privateKey;
    if (nsec != null) {
      Clipboard.setData(ClipboardData(text: nsec));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Clave privada (nsec) copiada. ¡Guárdala en un lugar seguro!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _saveProfile() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Actualizar perfil en Nostr (kind 0)
      // await NostrService().updateProfile(
      //   name: _nameController.text.trim(),
      //   about: _aboutController.text.trim(),
      //   nip05: _nip05Controller.text.trim(),
      // );

      setState(() => _isEditing = false);
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado (local)')),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        actions: [
          if (_isEditing)
            IconButton(
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.check),
              onPressed: _isLoading ? null : _saveProfile,
            ),
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() => _isEditing = true);
                // Los valores ya están en los controladores desde initState
              },
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Avatar
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Npub
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tu Npub (público)',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    appState.userNpub,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: appState.userNpub));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Npub copiado')),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copiar Npub'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Nsec (clave privada)
          Card(
            color: Colors.red.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.lock, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Tu Clave Privada (nsec)',
                        style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '⚠️ NUNCA compartas tu clave privada. Guárdala en un lugar seguro.',
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _copyNsec,
                    icon: const Icon(Icons.copy, color: Colors.red),
                    label: const Text(
                      'Copiar Clave Privada',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Nombre de perfil
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nombre',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    enabled: _isEditing,
                    decoration: const InputDecoration(
                      hintText: 'Tu nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // About
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Información',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _aboutController,
                    enabled: _isEditing,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Cuéntanos sobre ti',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // NIP-05
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'NIP-05 (opcional)',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nip05Controller,
                    enabled: _isEditing,
                    decoration: const InputDecoration(
                      hintText: 'usuario@dominio.com',
                      border: OutlineInputBorder(),
                      helperText: 'Verificación de identidad (opcional)',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Backup
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Backup',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tu clave privada (nsec) es tu backup. Si la pierdes, pierdes tu cuenta para siempre.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _copyNsec,
                    icon: const Icon(Icons.backup),
                    label: const Text('Respaldar Clave Privada'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
