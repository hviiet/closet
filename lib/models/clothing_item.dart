import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'clothing_category.dart';

part 'clothing_item.freezed.dart';
part 'clothing_item.g.dart';

@freezed
@HiveType(typeId: 0)
class ClothingItem with _$ClothingItem {
  const factory ClothingItem({
    @HiveField(0) required String id,
    @HiveField(1) required String imagePath,
    @HiveField(2) required ClothingCategory category,
    @HiveField(3) required DateTime dateAdded,
  }) = _ClothingItem;

  factory ClothingItem.fromJson(Map<String, dynamic> json) =>
      _$ClothingItemFromJson(json);
}
