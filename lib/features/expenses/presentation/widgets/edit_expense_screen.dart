import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/expense_form.dart';

class EditExpenseScreen extends StatelessWidget {
  final Map<String, dynamic>? initial;
  const EditExpenseScreen({super.key, this.initial});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Expense')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: ExpenseForm(
            initial: initial,
            onSubmit: (value) {
              // UI-only: biasanya panggil repo.update(...)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Expense updated (UI only)')),
              );
              context.pop();
            },
          ),
        ),
      ),
    );
  }
}
