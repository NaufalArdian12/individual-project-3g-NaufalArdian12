import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ---- Dummy data untuk card dashboard
  static final _items = <_DashboardItem>[
    _DashboardItem('Profile', Icons.person, Colors.green, '/profile'),
    _DashboardItem('Messages', Icons.message, Colors.orange, '/messages'),
    _DashboardItem('Settings', Icons.settings, Colors.purple, '/settings'),
    _DashboardItem('Help', Icons.help, Colors.red, '/help'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      // Gunakan Material 3 look jika ThemeData kamu mendukung
      backgroundColor: color.surface,
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 0,
        scrolledUnderElevation: 2,
        backgroundColor: color.surface,
        foregroundColor: color.onSurface,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          PopupMenuButton<String>(
            tooltip: 'More',
            itemBuilder:
                (context) => const [
                  PopupMenuItem(value: 'about', child: Text('About')),
                  PopupMenuItem(
                    value: 'feedback',
                    child: Text('Send Feedback'),
                  ),
                ],
            onSelected: (v) {
              // TODO: handle menu
            },
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              // TODO: Handle logout
            Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: _AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _GreetingHeader(),
                  const SizedBox(height: 16),
                  _SearchBar(),
                  const SizedBox(height: 16),
                  _QuickStatsRow(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          // Grid responsif
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.crossAxisExtent; // lebar konten
                // Atur kolom adaptif
                int crossAxisCount;
                if (width >= 1100) {
                  crossAxisCount = 4;
                } else if (width >= 800) {
                  crossAxisCount = 3;
                } else {
                  crossAxisCount = 2;
                }

                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = _items[index];
                    return _DashboardCard(item: item);
                  }, childCount: _items.length),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ====== Drawer yang proper dengan UserAccountsDrawerHeader
class _AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.primary, color.primaryContainer],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text('Welcome, Nopal'),
              accountEmail: const Text('nopal@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: color.onPrimary,
                child: Icon(Icons.person, size: 36, color: color.primary),
              ),
            ),
            _DrawerTile(
              icon: Icons.home_outlined,
              title: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerTile(
              icon: Icons.person_outline,
              title: 'Profile',
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, '/profile');
              },
            ),
            _DrawerTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, '/settings');
              },
            ),
            const Divider(),
            _DrawerTile(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                Navigator.pop(context);
                // TODO: handle logout
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: color.primary),
      title: Text(title),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      visualDensity: VisualDensity.compact,
    );
  }
}

// ====== Header salam + badge kecil
class _GreetingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: text.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text('Semoga produktif hari ini! ', style: text.bodyMedium),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.primaryContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'v1.0',
                      style: text.labelSmall?.copyWith(
                        color: color.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Avatar kecil untuk konsistensi
        CircleAvatar(
          radius: 22,
          backgroundColor: color.primaryContainer,
          child: Icon(Icons.person, color: color.onPrimaryContainer),
        ),
      ],
    );
  }
}

// ====== Search bar sederhana
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search anything…',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: color.surfaceContainerHighest.withOpacity(0.6),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color.primary, width: 1.6),
        ),
      ),
      onSubmitted: (q) {
        // TODO: handle search
      },
    );
  }
}

// ====== Quick stats (contoh dummy)
class _QuickStatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    Widget stat(String label, String value, IconData icon) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.surfaceContainerHighest.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.outlineVariant),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: text.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  label,
                  style: text.labelMedium?.copyWith(
                    color: color.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth > 600;
        return isWide
            ? Row(
              children: [
                Expanded(
                  child: stat('Unread Messages', '12', Icons.mail_outline),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: stat('Tasks Today', '5', Icons.check_circle_outline),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: stat(
                    'New Notifications',
                    '3',
                    Icons.notifications_outlined,
                  ),
                ),
              ],
            )
            : Column(
              children: [
                stat('Unread Messages', '12', Icons.mail_outline),
                const SizedBox(height: 10),
                stat('Tasks Today', '5', Icons.check_circle_outline),
                const SizedBox(height: 10),
                stat('New Notifications', '3', Icons.notifications_outlined),
              ],
            );
      },
    );
  }
}

// ====== Kartu Dashboard dengan animasi & gradient
class _DashboardCard extends StatelessWidget {
  final _DashboardItem item;
  const _DashboardCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return _InkScale(
      onTap: () {
        // TODO: Ganti dengan navigation kamu
        // Navigator.pushNamed(context, item.route);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Open ${item.title}')));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              item.color.withOpacity(0.15),
              color.primaryContainer.withOpacity(0.25),
            ],
          ),
          border: Border.all(color: color.outlineVariant),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon bubble
            Container(
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(item.icon, size: 28, color: item.color),
            ),
            const Spacer(),
            Text(
              item.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              'Tap to open',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: color.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

// ====== InkWell dengan efek scale halus
class _InkScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const _InkScale({required this.child, required this.onTap});

  @override
  State<_InkScale> createState() => _InkScaleState();
}

class _InkScaleState extends State<_InkScale>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _down(_) => setState(() => _scale = 0.98);
  void _up(_) => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _down,
      onTapCancel: () => _up(null),
      onTapUp: _up,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

class _DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;
  const _DashboardItem(this.title, this.icon, this.color, this.route);
}
