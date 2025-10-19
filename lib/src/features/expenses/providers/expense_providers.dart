import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pemrograman_mobile/features/expenses/domain/models/expense.dart';
import 'package:pemrograman_mobile/features/expenses/data/memory_expense_repository.dart';

// Provider untuk expense repository
final expenseRepositoryProvider = Provider<MemoryExpenseRepository>((ref) {
  return MemoryExpenseRepository();
});

// Provider untuk mendapatkan semua expenses
final expensesProvider = StreamProvider<List<Expense>>((ref) {
  final repository = ref.watch(expenseRepositoryProvider);
  return repository.watchAll();
});

// Provider untuk mendapatkan expenses bulan ini
final monthlyExpensesProvider = FutureProvider.family<List<Expense>, DateTime>((ref, date) async {
  final repository = ref.watch(expenseRepositoryProvider);
  return repository.byMonth(date.year, date.month);
});

// Provider untuk total expense bulan ini
final monthlyTotalProvider = FutureProvider.family<double, DateTime>((ref, date) async {
  final expenses = await ref.watch(monthlyExpensesProvider(date).future);
  return expenses.fold<double>(0, (sum, expense) => sum + expense.amount);
});

// Provider untuk expenses by category
final expensesByCategoryProvider = FutureProvider.family<Map<String, double>, DateTime>((ref, date) async {
  final expenses = await ref.watch(monthlyExpensesProvider(date).future);
  final Map<String, double> categoryTotals = {};
  
  for (final expense in expenses) {
    categoryTotals[expense.categoryId] = (categoryTotals[expense.categoryId] ?? 0) + expense.amount;
  }
  
  return categoryTotals;
});

// Notifier untuk menambah expense baru
class ExpenseNotifier extends StateNotifier<AsyncValue<void>> {
  ExpenseNotifier(this._repository) : super(const AsyncValue.data(null));
  
  final MemoryExpenseRepository _repository;
  
  Future<void> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String categoryId,
    String? note,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final expense = Expense.create(
        title: title,
        amount: amount,
        date: date,
        categoryId: categoryId,
        note: note,
      );
      
      await _repository.add(expense);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  Future<void> updateExpense(Expense expense) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.update(expense);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  Future<void> deleteExpense(String id) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.remove(id);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Provider untuk expense notifier
final expenseNotifierProvider = StateNotifierProvider<ExpenseNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(expenseRepositoryProvider);
  return ExpenseNotifier(repository);
});
