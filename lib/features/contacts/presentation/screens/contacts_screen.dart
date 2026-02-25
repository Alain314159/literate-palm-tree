import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/services/app_state.dart';
import '../../../../core/models/contact.dart';
import '../../../../core/services/hive_service.dart';
import '../../../chat/presentation/screens/chat_detail_screen.dart';
import 'add_contact_dialog.dart';

class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _showAddContactDialog(),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: contactsBox.watch(),
        builder: (context, snapshot) {
          final contacts = contactsBox.values.toList();
          
          if (contacts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Sin contactos',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Agrega contactos con su npub',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: _showAddContactDialog,
                    icon: const Icon(Icons.person_add),
                    label: const Text('Agregar Contacto'),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    contact.getDisplayName().substring(0, 2).toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(contact.getDisplayName()),
                subtitle: Text(contact.npub.substring(0, 12) + '...'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'block') {
                      _blockContact(contact);
                    } else if (value == 'delete') {
                      _deleteContact(contact);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'block',
                      child: Text('Bloquear'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Eliminar'),
                    ),
                  ],
                ),
                onTap: () {
                  // Navegar al chat
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailScreen(npub: contact.npub),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showAddContactDialog() {
    showDialog(
      context: context,
      builder: (_) => const AddContactDialog(),
    );
  }

  void _blockContact(Contact contact) {
    contactsBox.put(contact.npub, contact.copyWith(isBlocked: true));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${contact.getDisplayName()} bloqueado')),
    );
  }

  void _deleteContact(Contact contact) {
    contactsBox.delete(contact.npub);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${contact.getDisplayName()} eliminado')),
    );
  }
}
