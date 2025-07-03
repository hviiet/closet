import 'package:equatable/equatable.dart';
import '../models/models.dart';

enum ClothingStatus { initial, loading, success, failure }

class ClothingState extends Equatable {
  final ClothingStatus status;
  final List<ClothingItem> items;
  final List<ClothingItem> filteredItems;
  final ClothingCategory? selectedCategory;
  final String searchQuery;
  final String? errorMessage;

  const ClothingState({
    this.status = ClothingStatus.initial,
    this.items = const [],
    this.filteredItems = const [],
    this.selectedCategory,
    this.searchQuery = '',
    this.errorMessage,
  });

  ClothingState copyWith({
    ClothingStatus? status,
    List<ClothingItem>? items,
    List<ClothingItem>? filteredItems,
    ClothingCategory? selectedCategory,
    String? searchQuery,
    String? errorMessage,
    bool clearCategory = false,
  }) {
    return ClothingState(
      status: status ?? this.status,
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        filteredItems,
        selectedCategory,
        searchQuery,
        errorMessage,
      ];
}
