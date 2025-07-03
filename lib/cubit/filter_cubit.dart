import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/models.dart';

enum SortOption { dateAdded, category, recentlyUsed }

enum SortOrder { ascending, descending }

class FilterState extends Equatable {
  final ClothingCategory? selectedCategory;
  final SortOption sortOption;
  final SortOrder sortOrder;
  final bool isGridView;
  final List<String> selectedTags;
  final bool showOnlyFavorites;
  final DateRange? dateRange;
  final String searchQuery;

  const FilterState({
    this.selectedCategory,
    this.sortOption = SortOption.dateAdded,
    this.sortOrder = SortOrder.descending,
    this.isGridView = true,
    this.selectedTags = const [],
    this.showOnlyFavorites = false,
    this.dateRange,
    this.searchQuery = '',
  });

  FilterState copyWith({
    ClothingCategory? selectedCategory,
    SortOption? sortOption,
    SortOrder? sortOrder,
    bool? isGridView,
    List<String>? selectedTags,
    bool? showOnlyFavorites,
    DateRange? dateRange,
    bool clearCategory = false,
    bool clearTags = false,
    bool clearDateRange = false,
    String? searchQuery,
  }) {
    return FilterState(
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      sortOption: sortOption ?? this.sortOption,
      sortOrder: sortOrder ?? this.sortOrder,
      isGridView: isGridView ?? this.isGridView,
      selectedTags: clearTags ? [] : (selectedTags ?? this.selectedTags),
      showOnlyFavorites: showOnlyFavorites ?? this.showOnlyFavorites,
      dateRange: clearDateRange ? null : (dateRange ?? this.dateRange),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  bool get hasActiveFilters =>
      selectedCategory != null ||
      selectedTags.isNotEmpty ||
      showOnlyFavorites ||
      dateRange != null ||
      searchQuery.isNotEmpty;

  @override
  List<Object?> get props => [
        selectedCategory,
        sortOption,
        sortOrder,
        isGridView,
        selectedTags,
        showOnlyFavorites,
        dateRange,
        searchQuery,
      ];
}

class DateRange extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const DateRange({required this.startDate, required this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
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

  void addTag(String tag) {
    if (!state.selectedTags.contains(tag)) {
      final newTags = List<String>.from(state.selectedTags)..add(tag);
      emit(state.copyWith(selectedTags: newTags));
    }
  }

  void removeTag(String tag) {
    final newTags = List<String>.from(state.selectedTags)..remove(tag);
    emit(state.copyWith(selectedTags: newTags));
  }

  void clearTags() {
    emit(state.copyWith(clearTags: true));
  }

  void toggleFavorites() {
    emit(state.copyWith(showOnlyFavorites: !state.showOnlyFavorites));
  }

  void setDateRange(DateRange? range) {
    emit(state.copyWith(
      dateRange: range,
      clearDateRange: range == null,
    ));
  }

  void clearAllFilters() {
    emit(const FilterState(
      sortOption: SortOption.dateAdded,
      sortOrder: SortOrder.descending,
      isGridView: true,
    ));
  }

  /// Apply all filters and sorting to a list of clothing items
  List<ClothingItem> applyFilters(List<ClothingItem> items) {
    var filtered = List<ClothingItem>.from(items);

    // Apply category filter
    if (state.selectedCategory != null) {
      filtered = filtered
          .where((item) => item.category == state.selectedCategory)
          .toList();
    }

    // Apply date range filter
    if (state.dateRange != null) {
      filtered = filtered
          .where((item) =>
              item.dateAdded.isAfter(state.dateRange!.startDate
                  .subtract(const Duration(days: 1))) &&
              item.dateAdded.isBefore(
                  state.dateRange!.endDate.add(const Duration(days: 1))))
          .toList();
    }

    // Apply sorting
    filtered.sort((a, b) {
      int comparison = 0;

      switch (state.sortOption) {
        case SortOption.dateAdded:
          comparison = a.dateAdded.compareTo(b.dateAdded);
          break;
        case SortOption.category:
          comparison = a.category.displayName.compareTo(b.category.displayName);
          break;
        case SortOption.recentlyUsed:
          // For now, sort by date added as a proxy for recently used
          comparison = a.dateAdded.compareTo(b.dateAdded);
          break;
      }

      return state.sortOrder == SortOrder.ascending ? comparison : -comparison;
    });

    return filtered;
  }

  /// Get available tags from all items
  Set<String> getAvailableTags(List<ClothingItem> items) {
    // Return empty set since tags field was removed
    return <String>{};
  }
}
