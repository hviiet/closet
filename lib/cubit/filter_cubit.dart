import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/models.dart';

enum SortOption { dateAdded, category, name }

enum SortOrder { ascending, descending }

class FilterState extends Equatable {
  final ClothingCategory? selectedCategory;
  final SortOption sortOption;
  final SortOrder sortOrder;
  final bool isGridView;

  const FilterState({
    this.selectedCategory,
    this.sortOption = SortOption.dateAdded,
    this.sortOrder = SortOrder.descending,
    this.isGridView = true,
  });

  FilterState copyWith({
    ClothingCategory? selectedCategory,
    SortOption? sortOption,
    SortOrder? sortOrder,
    bool? isGridView,
    bool clearCategory = false,
  }) {
    return FilterState(
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      sortOption: sortOption ?? this.sortOption,
      sortOrder: sortOrder ?? this.sortOrder,
      isGridView: isGridView ?? this.isGridView,
    );
  }

  @override
  List<Object?> get props =>
      [selectedCategory, sortOption, sortOrder, isGridView];
}

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void setCategory(ClothingCategory? category) {
    emit(state.copyWith(
      selectedCategory: category,
      clearCategory: category == null,
    ));
  }

  void setSortOption(SortOption option) {
    emit(state.copyWith(sortOption: option));
  }

  void setSortOrder(SortOrder order) {
    emit(state.copyWith(sortOrder: order));
  }

  void toggleSortOrder() {
    final newOrder = state.sortOrder == SortOrder.ascending
        ? SortOrder.descending
        : SortOrder.ascending;
    emit(state.copyWith(sortOrder: newOrder));
  }

  void toggleViewMode() {
    emit(state.copyWith(isGridView: !state.isGridView));
  }

  void clearFilters() {
    emit(const FilterState());
  }
}
