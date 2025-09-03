import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import 'collection_repository.dart';

class SupabaseCollectionRepository implements CollectionRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Collection>> getAllCollections() async {
    try {
      final userId = supabase.auth.currentUser!.id;

      final response = await supabase
          .from('collections')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return response
          .map((collection) => Collection.fromJson(collection))
          .toList();
    } catch (e) {
      throw Exception('Failed to load collections: $e');
    }
  }

  @override
  Future<Collection?> getCollectionById(String id) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      final response = await supabase
          .from('collections')
          .select()
          .eq('id', id)
          .eq('user_id', userId)
          .single();

      return Collection.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addCollection(Collection collection) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase.from('collections').insert({
        ...collection.toJson(),
        'user_id': userId,
      });
    } catch (e) {
      throw Exception('Failed to add collection: $e');
    }
  }

  @override
  Future<void> updateCollection(Collection collection) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase
          .from('collections')
          .update(collection.toJson())
          .eq('id', collection.id)
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to update collection: $e');
    }
  }

  @override
  Future<void> deleteCollection(String id) async {
    try {
      final userId = supabase.auth.currentUser!.id;

      await supabase
          .from('collections')
          .delete()
          .eq('id', id)
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to delete collection: $e');
    }
  }

  @override
  Future<List<Collection>> searchCollections(String query) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final lowercaseQuery = query.toLowerCase();

      final response = await supabase
          .from('collections')
          .select()
          .eq('user_id', userId)
          .ilike('name', '%$lowercaseQuery%')
          .order('created_at', ascending: false);

      return response
          .map((collection) => Collection.fromJson(collection))
          .toList();
    } catch (e) {
      throw Exception('Failed to search collections: $e');
    }
  }
}
