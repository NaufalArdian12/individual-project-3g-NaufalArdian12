import '../models/category.dart';

abstract class CategoryRepository {
  Stream<List<Category>> watchAll();
  Future<List<Category>> getAll();
  Future<void> add(Category category);
  Future<void> rename(String id, String name);
  Future<void> remove(String id);
}
