import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: c.primary,
                  child: const Icon(
                    Icons.person,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Nopal',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text('nopal@example.com'),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => context.go('/settings'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
