import 'package:flutter/material.dart';
import '../widgets/expense_form.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: ExpenseForm(
            onSubmit: (value) {
              // UI-only: di sini biasanya panggil repo.add(...)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Expense saved (UI only)')),
              );
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
