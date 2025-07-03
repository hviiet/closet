import 'package:equatable/equatable.dart';
import '../models/models.dart';

abstract class ClothingEvent extends Equatable {
  const ClothingEvent();

  @override
  List<Object?> get props => [];
}

class LoadClothingItems extends ClothingEvent {}

class AddClothingItem extends ClothingEvent {
  final ClothingItem item;

  const AddClothingItem(this.item);

  @override
  List<Object> get props => [item];
}

class UpdateClothingItem extends ClothingEvent {
  final ClothingItem item;

  const UpdateClothingItem(this.item);

  @override
  List<Object> get props => [item];
}

class DeleteClothingItem extends ClothingEvent {
  final String itemId;

  const DeleteClothingItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class FilterClothingByCategory extends ClothingEvent {
  final ClothingCategory? category;

  const FilterClothingByCategory(this.category);

  @override
  List<Object?> get props => [category];
}
