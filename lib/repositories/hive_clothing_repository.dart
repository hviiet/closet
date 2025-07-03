import 'package:hive/hive.dart';
import '../models/models.dart';
import 'clothing_repository.dart';

class HiveClothingRepository implements ClothingRepository {
  static const String _boxName = 'clothing_items';
  late final Box<ClothingItem> _box;

  Future<void> init() async {
    _box = await Hive.openBox<ClothingItem>(_boxName);
  }

  @override
  Future<List<ClothingItem>> getAllItems() async {
    return _box.values.toList()
      ..sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
  }

  @override
  Future<ClothingItem?> getItemById(String id) async {
    return _box.get(id);
  }

  @override
  Future<List<ClothingItem>> getItemsByCategory(
      ClothingCategory category) async {
    return _box.values.where((item) => item.category == category).toList()
      ..sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
  }

  @override
  Future<void> addItem(ClothingItem item) async {
    await _box.put(item.id, item);
  }

  @override
  Future<void> updateItem(ClothingItem item) async {
    await _box.put(item.id, item);
  }

  @override
  Future<void> deleteItem(String id) async {
    await _box.delete(id);
  }

  @override
  Future<List<ClothingItem>> searchItems(String query) async {
    final lowercaseQuery = query.toLowerCase();
    return _box.values
        .where((item) =>
            item.category.displayName.toLowerCase().contains(lowercaseQuery))
        .toList();
  }
}
