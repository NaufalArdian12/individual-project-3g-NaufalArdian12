import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pemrograman_mobile/src/features/expenses/providers/expense_providers.dart';
import '../../../../shared/widgets/expense_animations.dart';

class RecentTransactionsList extends ConsumerWidget {
  const RecentTransactionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final expensesAsync = ref.watch(expensesProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.history, color: colorScheme.primary, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Recent Transactions',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => context.go('/statistics'),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              expensesAsync.when(
                data: (expenses) {
                  final recentExpenses =
                      expenses.toList()
                        ..sort((a, b) => b.date.compareTo(a.date));
                  final displayExpenses = recentExpenses.take(5).toList();

                  if (displayExpenses.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 64,
                            color: colorScheme.onSurface.withValues(alpha: 0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No expenses yet',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add your first expense to get started',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: displayExpenses.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final expense = displayExpenses[index];
                      return SlideInAnimation(
                        delay: Duration(milliseconds: 1000 + (index * 100)),
                        beginOffset: const Offset(0.3, 0),
                        child: _buildTransactionItem(context, expense),
                      );
                    },
                  );
                },
                loading:
                    () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                error:
                    (error, _) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red.withValues(alpha: 0.6),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Failed to load expenses',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              error.toString(),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.red.withValues(alpha: 0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, expense) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Map category ID to display name and color
    final categoryMap = {
      'food': {
        'name': 'Makanan',
        'color': Colors.orange,
        'icon': Icons.restaurant,
      },
      'transport': {
        'name': 'Transport',
        'color': Colors.blue,
        'icon': Icons.directions_car,
      },
      'utility': {
        'name': 'Tagihan',
        'color': Colors.green,
        'icon': Icons.receipt,
      },
      'entertainment': {
        'name': 'Hiburan',
        'color': Colors.purple,
        'icon': Icons.movie,
      },
      'other': {
        'name': 'Lainnya',
        'color': Colors.grey,
        'icon': Icons.category,
      },
    };

    final categoryInfo =
        categoryMap[expense.categoryId] ?? categoryMap['other']!;
    final categoryName = categoryInfo['name'] as String;
    final categoryColor = categoryInfo['color'] as Color;
    final categoryIcon = categoryInfo['icon'] as IconData;

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: categoryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(categoryIcon, color: categoryColor, size: 20),
        ),
        title: Text(
          expense.title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '$categoryName • ${_formatDate(expense.date)}',
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '-Rp ${_formatAmount(expense.amount)}',
              style: theme.textTheme.titleSmall?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onTap: () {
          // Navigate to transaction detail
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('View details for ${expense.title}')),
          );
        },
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(0);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}';
    }
  }
}
