import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final query =
        GoRouterState.of(context).extra is Map
            ? (GoRouterState.of(context).extra as Map)['query'] as String?
            : null;

    final messages =
        List.generate(
              20,
              (i) => {
                'id': '$i',
                'title': 'Message #$i',
                'snippet': 'Preview of message $i',
              },
            )
            .where(
              (m) =>
                  query == null || query.isEmpty
                      ? true
                      : m['title']!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: messages.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final m = messages[i];
          return ListTile(
            title: Text(m['title']!),
            subtitle: Text(m['snippet']!),
            leading: const Icon(Icons.mail_outline),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/message/${m['id']}'),
          );
        },
      ),
    );
  }
}
