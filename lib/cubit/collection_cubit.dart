import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/models.dart';
import '../repositories/collection_repository.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final CollectionRepository _collectionRepository;

  CollectionCubit(this._collectionRepository) : super(const CollectionState());

  Future<void> loadCollections() async {
    emit(state.copyWith(status: CollectionStatus.loading));
    try {
      final collections = await _collectionRepository.getAllCollections();
      emit(state.copyWith(
        status: CollectionStatus.success,
        collections: collections,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CollectionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> createCollection({
    required String id,
    required List<String> itemIds,
    required List<String> outfitIds,
  }) async {
    try {
      final collection = Collection(
        id: id,
        itemIds: itemIds,
        outfitIds: outfitIds,
        dateCreated: DateTime.now(),
      );

      await _collectionRepository.addCollection(collection);
      await loadCollections(); // Refresh the list
    } catch (e) {
      emit(state.copyWith(
        status: CollectionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateCollection(Collection collection) async {
    try {
      await _collectionRepository.updateCollection(collection);
      await loadCollections(); // Refresh the list
    } catch (e) {
      emit(state.copyWith(
        status: CollectionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> deleteCollection(String id) async {
    try {
      await _collectionRepository.deleteCollection(id);
      await loadCollections(); // Refresh the list
    } catch (e) {
      emit(state.copyWith(
        status: CollectionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> addItemToCollection(String collectionId, String itemId) async {
    try {
      final collection =
          await _collectionRepository.getCollectionById(collectionId);
      if (collection != null) {
        final updatedItemIds = [...collection.itemIds];
        if (!updatedItemIds.contains(itemId)) {
          updatedItemIds.add(itemId);
          final updatedCollection =
              collection.copyWith(itemIds: updatedItemIds);
          await updateCollection(updatedCollection);
        }
      }
    } catch (e) {
      emit(state.copyWith(
        status: CollectionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> addOutfitToCollection(
      String collectionId, String outfitId) async {
    try {
      final collection =
          await _collectionRepository.getCollectionById(collectionId);
      if (collection != null) {
        final updatedOutfitIds = [...collection.outfitIds];
        if (!updatedOutfitIds.contains(outfitId)) {
          updatedOutfitIds.add(outfitId);
          final updatedCollection =
              collection.copyWith(outfitIds: updatedOutfitIds);
          await updateCollection(updatedCollection);
        }
      }
    } catch (e) {
      emit(state.copyWith(
        status: CollectionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
