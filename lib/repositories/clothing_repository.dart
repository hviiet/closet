import '../models/models.dart';

abstract class ClothingRepository {
  Future<List<ClothingItem>> getAllItems();
  Future<ClothingItem?> getItemById(String id);
  Future<List<ClothingItem>> getItemsByCategory(ClothingCategory category);
  Future<void> addItem(ClothingItem item);
  Future<void> updateItem(ClothingItem item);
  Future<void> deleteItem(String id);
  Future<List<ClothingItem>> searchItems(String query);
}
