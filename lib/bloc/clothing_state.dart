import 'package:equatable/equatable.dart';
import '../models/models.dart';

enum ClothingStatus { initial, loading, success, failure }

class ClothingState extends Equatable {
  final ClothingStatus status;
  final List<ClothingItem> items;
  final ClothingCategory? selectedCategory;
  final String? errorMessage;

  const ClothingState({
    this.status = ClothingStatus.initial,
    this.items = const [],
    this.selectedCategory,
    this.errorMessage,
  });

  ClothingState copyWith({
    ClothingStatus? status,
    List<ClothingItem>? items,
    ClothingCategory? selectedCategory,
    String? errorMessage,
    bool clearCategory = false,
  }) {
    return ClothingState(
      status: status ?? this.status,
      items: items ?? this.items,
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        selectedCategory,
        errorMessage,
      ];
}
