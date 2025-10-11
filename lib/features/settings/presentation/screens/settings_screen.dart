import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged:
                (_) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Implement theme toggling here'),
                  ),
                ),
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('English'),
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: c.primary),
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
