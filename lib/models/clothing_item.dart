import 'package:freezed_annotation/freezed_annotation.dart';
import 'clothing_category.dart';

part 'clothing_item.freezed.dart';
part 'clothing_item.g.dart';

@freezed
class ClothingItem with _$ClothingItem {
  const factory ClothingItem({
    required String id,
    required String imagePath,
    required ClothingCategory category,
    required DateTime dateAdded,
  }) = _ClothingItem;

  factory ClothingItem.fromJson(Map<String, dynamic> json) =>
      _$ClothingItemFromJson(json);
}
