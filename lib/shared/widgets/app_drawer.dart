import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pemrograman_mobile/features/auth/data/datasources/session_local_data_source.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [c.primary, c.primaryContainer],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text('Welcome, Nopal'),
              accountEmail: const Text('nopal@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: c.onPrimary,
                child: Icon(Icons.person, size: 36, color: c.primary),
              ),
            ),
            _tile(context, Icons.home_outlined, 'Home', () => context.go('/')),
            _tile(
              context,
              Icons.person_outline,
              'Profile',
              () => context.go('/profile'),
            ),
            _tile(
              context,
              Icons.message_outlined,
              'Messages',
              () => context.go('/messages'),
            ),
            _tile(
              context,
              Icons.settings_outlined,
              'Settings',
              () => context.go('/settings'),
            ),
            const Divider(),
            _tile(
              context,
              Icons.info_outline,
              'About',
              () => context.go('/about'),
            ),
            _tile(
              context,
              Icons.feedback_outlined,
              'Send Feedback',
              () => context.go('/feedback'),
            ),
            const Divider(),
            _tile(context, Icons.logout, 'Logout', () async {
              Navigator.pop(context); // nutup drawer (ini aman)
              await SessionLocalDataSource().clear(); // hapus 'loggedInUser'
              if (context.mounted) context.go('/login');
            }),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    final c = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: c.primary),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      visualDensity: VisualDensity.compact,
    );
  }
}
