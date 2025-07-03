import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/models.dart';

class OutfitState extends Equatable {
  final List<ClothingItem> selectedItems;
  final Map<ClothingCategory, ClothingItem?> selectedByCategory;
  final String? outfitName;
  final String? notes;
  final List<String>? tags;
  final bool isEditing;
  final String? editingOutfitId;

  const OutfitState({
    this.selectedItems = const [],
    this.selectedByCategory = const {},
    this.outfitName,
    this.notes,
    this.tags,
    this.isEditing = false,
    this.editingOutfitId,
  });

  OutfitState copyWith({
    List<ClothingItem>? selectedItems,
    Map<ClothingCategory, ClothingItem?>? selectedByCategory,
    String? outfitName,
    String? notes,
    List<String>? tags,
    bool? isEditing,
    String? editingOutfitId,
  }) {
    return OutfitState(
      selectedItems: selectedItems ?? this.selectedItems,
      selectedByCategory: selectedByCategory ?? this.selectedByCategory,
      outfitName: outfitName ?? this.outfitName,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      isEditing: isEditing ?? this.isEditing,
      editingOutfitId: editingOutfitId ?? this.editingOutfitId,
    );
  }

  bool get canSaveOutfit =>
      selectedItems.isNotEmpty && outfitName?.isNotEmpty == true;

  @override
  List<Object?> get props => [
        selectedItems,
        selectedByCategory,
        outfitName,
        notes,
        tags,
        isEditing,
        editingOutfitId,
      ];
}

class OutfitCubit extends Cubit<OutfitState> {
  OutfitCubit() : super(const OutfitState());

  void selectItem(ClothingItem item) {
    final newSelectedItems = List<ClothingItem>.from(state.selectedItems);
    final newSelectedByCategory =
        Map<ClothingCategory, ClothingItem?>.from(state.selectedByCategory);

    if (newSelectedItems.contains(item)) {
      newSelectedItems.remove(item);
      newSelectedByCategory[item.category] = null;
    } else {
      // Replace existing item in same category
      if (newSelectedByCategory[item.category] != null) {
        newSelectedItems.remove(newSelectedByCategory[item.category]);
      }
      newSelectedItems.add(item);
      newSelectedByCategory[item.category] = item;
    }

    emit(state.copyWith(
      selectedItems: newSelectedItems,
      selectedByCategory: newSelectedByCategory,
    ));
  }

  void removeItem(ClothingItem item) {
    final newSelectedItems = List<ClothingItem>.from(state.selectedItems)
      ..remove(item);
    final newSelectedByCategory =
        Map<ClothingCategory, ClothingItem?>.from(state.selectedByCategory);
    newSelectedByCategory[item.category] = null;

    emit(state.copyWith(
      selectedItems: newSelectedItems,
      selectedByCategory: newSelectedByCategory,
    ));
  }

  void setOutfitName(String name) {
    emit(state.copyWith(outfitName: name));
  }

  void setNotes(String notes) {
    emit(state.copyWith(notes: notes));
  }

  void setTags(List<String> tags) {
    emit(state.copyWith(tags: tags));
  }

  void startEditing(OutfitSet outfit, List<ClothingItem> allItems) {
    final selectedItems =
        allItems.where((item) => outfit.itemIds.contains(item.id)).toList();
    final selectedByCategory = <ClothingCategory, ClothingItem?>{};

    for (final item in selectedItems) {
      selectedByCategory[item.category] = item;
    }

    emit(state.copyWith(
      selectedItems: selectedItems,
      selectedByCategory: selectedByCategory,
      outfitName: outfit.name,
      notes: outfit.notes,
      tags: outfit.tags,
      isEditing: true,
      editingOutfitId: outfit.id,
    ));
  }

  void clearSelection() {
    emit(const OutfitState());
  }

  bool isItemSelected(ClothingItem item) {
    return state.selectedItems.contains(item);
  }

  ClothingItem? getSelectedItemForCategory(ClothingCategory category) {
    return state.selectedByCategory[category];
  }
}
