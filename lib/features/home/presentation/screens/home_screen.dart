import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/expense_animations.dart';
import '../widgets/expense_overview_card.dart';
import '../widgets/quick_action_buttons.dart';
import '../widgets/recent_transactions_list.dart';
import '../widgets/monthly_chart_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No new notifications')),
            ),
            icon: const Icon(Icons.notifications_outlined),
          ),
          PopupMenuButton<String>(
            itemBuilder: (c) => [
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined),
                    SizedBox(width: 12),
                    Text('Settings'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'about',
                child: Row(
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 12),
                    Text('About'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 12),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                context.go('/login');
              } else {
                context.go('/$value');
              }
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          // Welcome Section
          SliverToBoxAdapter(
            child: SlideInAnimation(
              delay: const Duration(milliseconds: 100),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good ${_getGreeting()}!',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Let\'s track your expenses today',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Overview Cards
          SliverToBoxAdapter(
            child: SlideInAnimation(
              delay: const Duration(milliseconds: 200),
              child: const ExpenseOverviewCard(),
            ),
          ),

          // Monthly Chart
          SliverToBoxAdapter(
            child: SlideInAnimation(
              delay: const Duration(milliseconds: 300),
              child: const MonthlyChartCard(),
            ),
          ),

          // Quick Actions
          SliverToBoxAdapter(
            child: SlideInAnimation(
              delay: const Duration(milliseconds: 400),
              child: const QuickActionButtons(),
            ),
          ),

          // Recent Transactions
          SliverToBoxAdapter(
            child: SlideInAnimation(
              delay: const Duration(milliseconds: 500),
              child: const RecentTransactionsList(),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      floatingActionButton: ScaleInAnimation(
        delay: const Duration(milliseconds: 600),
        child: FloatingActionButton.extended(
          onPressed: () => context.go('/add-expense'),
          icon: const Icon(Icons.add),
          label: const Text('Add Expense'),
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }
}