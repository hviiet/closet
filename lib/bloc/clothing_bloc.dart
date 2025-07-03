import 'package:flutter_bloc/flutter_bloc.dart';
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
      emit(state.copyWith(
        status: ClothingStatus.success,
        items: items,
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
      emit(state.copyWith(
        status: ClothingStatus.success,
        items: items,
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
      emit(state.copyWith(
        status: ClothingStatus.success,
        items: items,
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
    emit(state.copyWith(
      selectedCategory: event.category,
      clearCategory: event.category == null,
    ));
  }
}
