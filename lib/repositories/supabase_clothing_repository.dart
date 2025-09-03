import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import 'clothing_repository.dart';

class SupabaseClothingRepository implements ClothingRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<List<ClothingItem>> getAllItems() async {
    try {
      final userId = supabase.auth.currentUser!.id;

      final response = await supabase
          .from('clothing_items')
          .select()
          .eq('user_id', userId)
          .order('date_added', ascending: false);

      return response.map((item) => ClothingItem.fromJson(item)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load clothing items: $e');
    }
  }

  @override
  Future<ClothingItem?> getItemById(String id) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      final response = await supabase
          .from('clothing_items')
          .select()
          .eq('id', id)
          .eq('user_id', userId)
          .single();

      return ClothingItem.fromJson(response);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<List<ClothingItem>> getItemsByCategory(
      ClothingCategory category) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      final response = await supabase
          .from('clothing_items')
          .select()
          .eq('user_id', userId)
          .eq('category', category.name)
          .order('date_added', ascending: false);

      return response.map((item) => ClothingItem.fromJson(item)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load items by category: $e');
    }
  }

  @override
  Future<void> addItem(ClothingItem item) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase.from('clothing_items').insert({
        ...item.toJson(),
        'user_id': userId,
      });
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to add clothing item: $e');
    }
  }

  @override
  Future<void> updateItem(ClothingItem item) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase
          .from('clothing_items')
          .update(item.toJson())
          .eq('id', item.id)
          .eq('user_id', userId);
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to update clothing item: $e');
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase
          .from('clothing_items')
          .delete()
          .eq('id', id)
          .eq('user_id', userId);
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to delete clothing item: $e');
    }
  }

  @override
  Future<List<ClothingItem>> searchItems(String query) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final lowercaseQuery = query.toLowerCase();

      final response = await supabase
          .from('clothing_items')
          .select()
          .eq('user_id', userId)
          .ilike('category', '%$lowercaseQuery%')
          .order('date_added', ascending: false);

      return response.map((item) => ClothingItem.fromJson(item)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to search clothing items: $e');
    }
  }
}
