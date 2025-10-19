import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pemrograman_mobile/src/features/expenses/providers/expense_providers.dart';
import '../../../../shared/widgets/expense_animations.dart';

class ExpenseOverviewCard extends ConsumerWidget {
  const ExpenseOverviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDate = DateTime.now();
    final monthlyTotal = ref.watch(monthlyTotalProvider(currentDate));
    final monthlyBudget = 5000000.0; // Fixed budget for demo

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Total Expenses
          Expanded(
            child: BounceInAnimation(
              delay: const Duration(milliseconds: 700),
              child: monthlyTotal.when(
                data: (total) => _buildStatCard(
                  context,
                  'This Month',
                  'Rp ${_formatCurrency(total)}',
                  Icons.trending_up,
                  Colors.red,
                  '${total.toInt()} spent',
                ),
                loading: () => _buildStatCard(
                  context,
                  'This Month',
                  'Loading...',
                  Icons.trending_up,
                  Colors.red,
                  'Calculating...',
                ),
                error: (_, __) => _buildStatCard(
                  context,
                  'This Month',
                  'Error',
                  Icons.error,
                  Colors.red,
                  'Failed to load',
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Monthly Budget
          Expanded(
            child: BounceInAnimation(
              delay: const Duration(milliseconds: 800),
              child: monthlyTotal.when(
                data: (total) => _buildStatCard(
                  context,
                  'Monthly Budget',
                  'Rp ${_formatCurrency(monthlyBudget)}',
                  Icons.account_balance_wallet,
                  Colors.blue,
                  '${((total / monthlyBudget) * 100).toInt()}% used',
                ),
                loading: () => _buildStatCard(
                  context,
                  'Monthly Budget',
                  'Rp ${_formatCurrency(monthlyBudget)}',
                  Icons.account_balance_wallet,
                  Colors.blue,
                  'Loading...',
                ),
                error: (_, __) => _buildStatCard(
                  context,
                  'Monthly Budget',
                  'Rp ${_formatCurrency(monthlyBudget)}',
                  Icons.account_balance_wallet,
                  Colors.blue,
                  'Error',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String amount,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.more_vert,
                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
