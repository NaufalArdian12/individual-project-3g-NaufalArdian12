import '../models/expense.dart';

abstract class ExpenseRepository {
  Stream<List<Expense>> watchAll();           // live list (untuk list & statistik)
  Future<List<Expense>> getAll();             // one-shot
  Future<void> add(Expense expense);
  Future<void> update(Expense expense);
  Future<void> remove(String id);

  // helper query (opsional)
  Future<List<Expense>> byMonth(int year, int month);
}
