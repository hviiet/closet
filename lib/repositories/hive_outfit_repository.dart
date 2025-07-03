import 'package:hive/hive.dart';
import '../models/models.dart';
import 'outfit_repository.dart';

class HiveOutfitRepository implements OutfitRepository {
  static const String _boxName = 'outfit_sets';
  late final Box<OutfitSet> _box;

  Future<void> init() async {
    _box = await Hive.openBox<OutfitSet>(_boxName);
  }

  @override
  Future<List<OutfitSet>> getAllOutfits() async {
    return _box.values.toList()
      ..sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
  }

  @override
  Future<OutfitSet?> getOutfitById(String id) async {
    return _box.get(id);
  }

  @override
  Future<void> addOutfit(OutfitSet outfit) async {
    await _box.put(outfit.id, outfit);
  }

  @override
  Future<void> updateOutfit(OutfitSet outfit) async {
    await _box.put(outfit.id, outfit);
  }

  @override
  Future<void> deleteOutfit(String id) async {
    await _box.delete(id);
  }

  @override
  Future<List<OutfitSet>> searchOutfits(String query) async {
    final lowercaseQuery = query.toLowerCase();
    return _box.values
        .where((outfit) =>
            outfit.name.toLowerCase().contains(lowercaseQuery) ||
            outfit.notes?.toLowerCase().contains(lowercaseQuery) == true ||
            outfit.tags?.any(
                    (tag) => tag.toLowerCase().contains(lowercaseQuery)) ==
                true)
        .toList()
      ..sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
  }
}
