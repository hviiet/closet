// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outfit_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OutfitSetImpl _$$OutfitSetImplFromJson(Map<String, dynamic> json) =>
    _$OutfitSetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      itemIds:
          (json['item_ids'] as List<dynamic>).map((e) => e as String).toList(),
      dateCreated: DateTime.parse(json['date_created'] as String),
      notes: json['notes'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$OutfitSetImplToJson(_$OutfitSetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'item_ids': instance.itemIds,
      'date_created': instance.dateCreated.toIso8601String(),
      'notes': instance.notes,
      'tags': instance.tags,
    };
