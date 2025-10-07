import 'dart:async';
import 'package:flutter/material.dart';
import '../domain/models/category.dart';
import '../domain/repositories/category_repository.dart';

class MemoryCategoryRepository implements CategoryRepository {
  final _items = <Category>[
    Category(id: 'food', name: 'Makanan', color: Colors.orange.value),
    Category(id: 'transport', name: 'Transport', color: Colors.blue.value),
    Category(id: 'utility', name: 'Utilitas', color: Colors.green.value),
  ];
  final _ctrl = StreamController<List<Category>>.broadcast();

  MemoryCategoryRepository() {
    _emit();
  }
  void _emit() => _ctrl.add(List.unmodifiable(_items));

  @override
  Stream<List<Category>> watchAll() => _ctrl.stream;

  @override
  Future<List<Category>> getAll() async => List.unmodifiable(_items);

  @override
  Future<void> add(Category category) async {
    _items.add(category);
    _emit();
  }

  @override
  Future<void> rename(String id, String name) async {
    final i = _items.indexWhere((c) => c.id == id);
    if (i != -1) _items[i] = _items[i].copyWith(name: name);
    _emit();
  }

  @override
  Future<void> remove(String id) async {
    _items.removeWhere((c) => c.id == id);
    _emit();
  }
}
