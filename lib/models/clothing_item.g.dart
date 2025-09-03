// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clothing_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClothingItemImpl _$$ClothingItemImplFromJson(Map<String, dynamic> json) =>
    _$ClothingItemImpl(
      id: json['id'] as String,
      imagePath: json['image_path'] as String,
      category: $enumDecode(_$ClothingCategoryEnumMap, json['category']),
      dateAdded: DateTime.parse(json['date_added'] as String),
    );

Map<String, dynamic> _$$ClothingItemImplToJson(_$ClothingItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_path': instance.imagePath,
      'category': _$ClothingCategoryEnumMap[instance.category]!,
      'date_added': instance.dateAdded.toIso8601String(),
    };

const _$ClothingCategoryEnumMap = {
  ClothingCategory.tops: 'tops',
  ClothingCategory.bottoms: 'bottoms',
  ClothingCategory.shoes: 'shoes',
  ClothingCategory.accessories: 'accessories',
  ClothingCategory.outerwear: 'outerwear',
  ClothingCategory.underwear: 'underwear',
  ClothingCategory.sleepwear: 'sleepwear',
  ClothingCategory.sportswear: 'sportswear',
};
