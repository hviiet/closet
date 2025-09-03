// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionImpl _$$CollectionImplFromJson(Map<String, dynamic> json) =>
    _$CollectionImpl(
      id: json['id'] as String,
      itemIds:
          (json['item_ids'] as List<dynamic>).map((e) => e as String).toList(),
      outfitIds: (json['outfit_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      dateCreated: DateTime.parse(json['date_created'] as String),
    );

Map<String, dynamic> _$$CollectionImplToJson(_$CollectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_ids': instance.itemIds,
      'outfit_ids': instance.outfitIds,
      'date_created': instance.dateCreated.toIso8601String(),
    };
