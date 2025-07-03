import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/models.dart';
import '../repositories/clothing_repository.dart';
import 'clothing_event.dart';
import 'clothing_state.dart';

class ClothingBloc extends Bloc<ClothingEvent, ClothingState> {
  final ClothingRepository _clothingRepository;

  ClothingBloc({
    required ClothingRepository clothingRepository,
  })  : _clothingRepository = clothingRepository,
        super(const ClothingState()) {
    on<LoadClothingItems>(_onLoadClothingItems);
    on<AddClothingItem>(_onAddClothingItem);
    on<UpdateClothingItem>(_onUpdateClothingItem);
    on<DeleteClothingItem>(_onDeleteClothingItem);
    on<FilterClothingByCategory>(_onFilterClothingByCategory);
    on<SearchClothingItems>(_onSearchClothingItems);
  }

  Future<void> _onLoadClothingItems(
    LoadClothingItems event,
    Emitter<ClothingState> emit,
  ) async {
    emit(state.copyWith(status: ClothingStatus.loading));
    try {
      final items = await _clothingRepository.getAllItems();
      emit(state.copyWith(
        status: ClothingStatus.success,
        items: items,
        filteredItems: items,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ClothingStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onAddClothingItem(
    AddClothingItem event,
    Emitter<ClothingState> emit,
  ) async {
    try {
      await _clothingRepository.addItem(event.item);
      final items = await _clothingRepository.getAllItems();
      final filteredItems = _applyFilters(items);
      emit(state.copyWith(
        status: ClothingStatus.success,
        items: items,
        filteredItems: filteredItems,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ClothingStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onUpdateClothingItem(
    UpdateClothingItem event,
    Emitter<ClothingState> emit,
  ) async {
    try {
      await _clothingRepository.updateItem(event.item);
      final items = await _clothingRepository.getAllItems();
      final filteredItems = _applyFilters(items);
      emit(state.copyWith(
        status: ClothingStatus.success,
        items: items,
        filteredItems: filteredItems,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ClothingStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onDeleteClothingItem(
    DeleteClothingItem event,
    Emitter<ClothingState> emit,
  ) async {
    try {
      await _clothingRepository.deleteItem(event.itemId);
      final items = await _clothingRepository.getAllItems();
      final filteredItems = _applyFilters(items);
      emit(state.copyWith(
        status: ClothingStatus.success,
        items: items,
        filteredItems: filteredItems,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ClothingStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onFilterClothingByCategory(
    FilterClothingByCategory event,
    Emitter<ClothingState> emit,
  ) async {
    final filteredItems = _applyFilters(state.items, category: event.category);
    emit(state.copyWith(
      selectedCategory: event.category,
      filteredItems: filteredItems,
      clearCategory: event.category == null,
    ));
  }

  Future<void> _onSearchClothingItems(
    SearchClothingItems event,
    Emitter<ClothingState> emit,
  ) async {
    if (event.query.isEmpty) {
      final filteredItems = _applyFilters(state.items);
      emit(state.copyWith(
        searchQuery: event.query,
        filteredItems: filteredItems,
      ));
    } else {
      try {
        final searchResults =
            await _clothingRepository.searchItems(event.query);
        final filteredItems = _applyFilters(searchResults);
        emit(state.copyWith(
          searchQuery: event.query,
          filteredItems: filteredItems,
        ));
      } catch (error) {
        emit(state.copyWith(
          status: ClothingStatus.failure,
          errorMessage: error.toString(),
        ));
      }
    }
  }

  List<ClothingItem> _applyFilters(
    List<ClothingItem> items, {
    ClothingCategory? category,
  }) {
    var filtered = List<ClothingItem>.from(items);

    final activeCategory = category ?? state.selectedCategory;
    if (activeCategory != null) {
      filtered =
          filtered.where((item) => item.category == activeCategory).toList();
    }

    return filtered;
  }
}
