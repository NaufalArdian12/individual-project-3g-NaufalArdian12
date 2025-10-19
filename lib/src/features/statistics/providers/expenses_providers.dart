import 'package:flutter_riverpod/flutter_riverpod.dart';

final byCategoryProvider = Provider<Map<String, double>>((ref) {
  return {
    'Makanan': 350000.0,
    'Transport': 120000.0,
    'Tagihan': 420000.0,
    'Hiburan': 180000.0,
  };
});

final totalExpenseProvider = Provider<double>((ref) {
  final map = ref.watch(byCategoryProvider);
  return map.values.fold<double>(0, (a, b) => a + b);
});

final transactionCountProvider = StateProvider<int>((ref) => 24);
