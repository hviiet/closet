import '../models/models.dart';

abstract class CollectionRepository {
  Future<List<Collection>> getAllCollections();
  Future<Collection?> getCollectionById(String id);
  Future<void> addCollection(Collection collection);
  Future<void> updateCollection(Collection collection);
  Future<void> deleteCollection(String id);
  Future<List<Collection>> searchCollections(String query);
}
