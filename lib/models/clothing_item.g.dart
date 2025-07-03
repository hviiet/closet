// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clothing_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClothingItemAdapter extends TypeAdapter<ClothingItem> {
  @override
  final int typeId = 0;

  @override
  ClothingItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClothingItem(
      id: fields[0] as String,
      imagePath: fields[1] as String,
      category: fields[2] as ClothingCategory,
      dateAdded: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ClothingItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.dateAdded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClothingItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClothingItemImpl _$$ClothingItemImplFromJson(Map<String, dynamic> json) =>
    _$ClothingItemImpl(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      category: $enumDecode(_$ClothingCategoryEnumMap, json['category']),
      dateAdded: DateTime.parse(json['dateAdded'] as String),
    );

Map<String, dynamic> _$$ClothingItemImplToJson(_$ClothingItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'category': _$ClothingCategoryEnumMap[instance.category]!,
      'dateAdded': instance.dateAdded.toIso8601String(),
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
