import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import 'outfit_repository.dart';

class SupabaseOutfitRepository implements OutfitRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<List<OutfitSet>> getAllOutfits() async {
    try {
      final userId = supabase.auth.currentUser!.id;

      final response = await supabase
          .from('outfit_sets')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return response.map((outfit) => OutfitSet.fromJson(outfit)).toList();
    } catch (e) {
      throw Exception('Failed to load outfits: $e');
    }
  }

  @override
  Future<OutfitSet?> getOutfitById(String id) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      final response = await supabase
          .from('outfit_sets')
          .select()
          .eq('id', id)
          .eq('user_id', userId)
          .single();

      return OutfitSet.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addOutfit(OutfitSet outfit) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase.from('outfit_sets').insert({
        ...outfit.toJson(),
        'user_id': userId,
      });
    } catch (e) {
      throw Exception('Failed to add outfit: $e');
    }
  }

  @override
  Future<void> updateOutfit(OutfitSet outfit) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase
          .from('outfit_sets')
          .update(outfit.toJson())
          .eq('id', outfit.id)
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to update outfit: $e');
    }
  }

  @override
  Future<void> deleteOutfit(String id) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase
          .from('outfit_sets')
          .delete()
          .eq('id', id)
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to delete outfit: $e');
    }
  }

  @override
  Future<List<OutfitSet>> searchOutfits(String query) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final lowercaseQuery = query.toLowerCase();

      final response = await supabase
          .from('outfit_sets')
          .select()
          .eq('user_id', userId)
          .ilike('name', '%$lowercaseQuery%')
          .order('created_at', ascending: false);

      return response.map((outfit) => OutfitSet.fromJson(outfit)).toList();
    } catch (e) {
      throw Exception('Failed to search outfits: $e');
    }
  }
}
