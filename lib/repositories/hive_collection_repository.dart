import 'package:hive/hive.dart';
import '../models/models.dart';
import 'collection_repository.dart';

class HiveCollectionRepository implements CollectionRepository {
  static const String _boxName = 'collections';
  late final Box<Collection> _box;

  Future<void> init() async {
    _box = await Hive.openBox<Collection>(_boxName);
  }

  @override
  Future<List<Collection>> getAllCollections() async {
    return _box.values.toList()
      ..sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
  }

  @override
  Future<Collection?> getCollectionById(String id) async {
    return _box.get(id);
  }

  @override
  Future<void> addCollection(Collection collection) async {
    await _box.put(collection.id, collection);
  }

  @override
  Future<void> updateCollection(Collection collection) async {
    await _box.put(collection.id, collection);
  }

  @override
  Future<void> deleteCollection(String id) async {
    await _box.delete(id);
  }

  @override
  Future<List<Collection>> searchCollections(String query) async {
    final lowercaseQuery = query.toLowerCase();
    return _box.values
        .where((collection) =>
            collection.id.toLowerCase().contains(lowercaseQuery))
        .toList()
      ..sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
  }
}
