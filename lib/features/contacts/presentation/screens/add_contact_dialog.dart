import 'package:flutter/material.dart';
import '../../../../core/models/contact.dart';
import '../../../../core/services/hive_service.dart';

class AddContactDialog extends StatefulWidget {
  const AddContactDialog({super.key});

  @override
  State<AddContactDialog> createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  final _npubController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _npubController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _addContact() async {
    final npub = _npubController.text.trim();
    final name = _nameController.text.trim();

    if (npub.isEmpty) {
      setState(() => _error = 'Ingresa el npub del contacto');
      return;
    }

    if (!npub.startsWith('npub1')) {
      setState(() => _error = 'El npub debe comenzar con npub1');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final contact = Contact(
        npub: npub,
        customName: name.isEmpty ? null : name,
        createdAt: DateTime.now(),
      );

      await contactsBox.put(npub, contact);

      if (!mounted) return;
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contacto agregado exitosamente')),
      );
    } catch (e) {
      setState(() {
        _error = 'Error al agregar: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Contacto'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nombre (opcional)',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _npubController,
            decoration: const InputDecoration(
              labelText: 'Npub',
              prefixIcon: Icon(Icons.key),
              helperText: 'Comienza con npub1...',
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 16),
            Text(
              _error!,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _addContact,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Agregar'),
        ),
      ],
    );
  }
}
