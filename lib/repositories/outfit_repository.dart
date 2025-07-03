import '../models/models.dart';

abstract class OutfitRepository {
  Future<List<OutfitSet>> getAllOutfits();
  Future<OutfitSet?> getOutfitById(String id);
  Future<void> addOutfit(OutfitSet outfit);
  Future<void> updateOutfit(OutfitSet outfit);
  Future<void> deleteOutfit(String id);
  Future<List<OutfitSet>> searchOutfits(String query);
}
