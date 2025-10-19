import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pemrograman_mobile/src/features/expenses/providers/expense_providers.dart';
import '../widgets/expense_form.dart';

class AddExpenseScreen extends ConsumerWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseNotifier = ref.watch(expenseNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: ExpenseForm(
            onSubmit: (value) async {
              final amountStr = value['amount'] as String;
              final amount = double.tryParse(amountStr.replaceAll('.', '').replaceAll(',', '.'));
              
              if (amount == null || amount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid amount'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              
              // Map category name to category ID
              final categoryMap = {
                'Makanan': 'food',
                'Transport': 'transport',
                'Tagihan': 'utility',
                'Hiburan': 'entertainment',
                'Lainnya': 'other',
              };
              
              final categoryId = categoryMap[value['category']] ?? 'other';
              
              await ref.read(expenseNotifierProvider.notifier).addExpense(
                title: value['title'] as String,
                amount: amount,
                date: value['date'] as DateTime,
                categoryId: categoryId,
                note: value['note'] as String?,
              );
              
              // Check if the widget is still in the widget tree
              if (context.mounted) {
                if (expenseNotifier.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${expenseNotifier.error}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Expense saved successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  // Use GoRouter navigation instead of Navigator.pop()
                  context.go('/');
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
