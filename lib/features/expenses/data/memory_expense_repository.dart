import 'dart:async';
import '../domain/models/expense.dart';
import '../domain/repositories/expense_repository.dart';

class MemoryExpenseRepository implements ExpenseRepository {
  final _items = <Expense>[];
  final _ctrl = StreamController<List<Expense>>.broadcast();

  MemoryExpenseRepository() {
    // contoh seed data
    _items.addAll([
      Expense.create(
        title: 'Kopi',
        amount: 15000,
        date: DateTime.now(),
        categoryId: 'food',
      ),
      Expense.create(
        title: 'Pulsa',
        amount: 50000,
        date: DateTime.now().subtract(const Duration(days: 1)),
        categoryId: 'utility',
      ),
    ]);
    _emit();
  }

  void _emit() => _ctrl.add(List.unmodifiable(_items));

  @override
  Stream<List<Expense>> watchAll() => _ctrl.stream;

  @override
  Future<List<Expense>> getAll() async => List.unmodifiable(_items);

  @override
  Future<void> add(Expense expense) async {
    _items.add(expense);
    _emit();
  }

  @override
  Future<void> update(Expense expense) async {
    final idx = _items.indexWhere((e) => e.id == expense.id);
    if (idx != -1) _items[idx] = expense;
    _emit();
  }

  @override
  Future<void> remove(String id) async {
    _items.removeWhere((e) => e.id == id);
    _emit();
  }

  @override
  Future<List<Expense>> byMonth(int year, int month) async =>
      _items
          .where((e) => e.date.year == year && e.date.month == month)
          .toList();
}
