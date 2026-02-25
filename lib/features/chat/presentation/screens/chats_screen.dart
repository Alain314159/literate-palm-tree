import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cerlita'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implementar búsqueda
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // TODO: Implementar acciones
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'new_chat',
                child: Text('Nuevo chat'),
              ),
              const PopupMenuItem(
                value: 'new_group',
                child: Text('Nuevo grupo'),
              ),
              const PopupMenuItem(
                value: 'backup',
                child: Text('Backup'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              'Tus chats aparecerán aquí',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Comienza un chat con el npub de un contacto',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Abrir diálogo para nuevo chat
              },
              icon: const Icon(Icons.add),
              label: const Text('Nuevo Chat'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Abrir diálogo para agregar contacto o nuevo chat
        },
        icon: const Icon(Icons.add),
        label: const Text('Chat'),
      ),
    );
  }
}
