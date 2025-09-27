import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../widgets/greeting_header.dart';
import '../widgets/search_field.dart';
import '../widgets/quick_stats_row.dart';
import '../widgets/dashboard_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final items = [
    DashboardItem('Profile', Icons.person, Colors.green, '/profile'),
    DashboardItem('Messages', Icons.message, Colors.orange, '/messages'),
    DashboardItem('Settings', Icons.settings, Colors.purple, '/settings'),
    DashboardItem('Help', Icons.help, Colors.red, '/help'),
  ];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: color.surface,
      appBar: AppBar(
        title: const Text('Home'),
        scrolledUnderElevation: 2,
        backgroundColor: color.surface,
        foregroundColor: color.onSurface,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed:
                () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No new notifications')),
                ),
            icon: const Icon(Icons.notifications_outlined),
          ),
          PopupMenuButton<String>(
            itemBuilder:
                (c) => const [
                  PopupMenuItem(value: 'about', child: Text('About')),
                  PopupMenuItem(
                    value: 'feedback',
                    child: Text('Send Feedback'),
                  ),
                ],
            onSelected: (v) => context.go('/$v'),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              // UI-only: clear ke login
              context.go('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  GreetingHeader(),
                  SizedBox(height: 16),
                  HomeSearchField(),
                  SizedBox(height: 16),
                  QuickStatsRow(),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.crossAxisExtent;
                final cross = w >= 1100 ? 4 : (w >= 800 ? 3 : 2);
                return SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cross,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: items.length,
                  itemBuilder:
                      (c, i) => DashboardCard(
                        item: items[i],
                        onTap: () => context.go(items[i].route),
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
