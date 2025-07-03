// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionAdapter extends TypeAdapter<Collection> {
  @override
  final int typeId = 2;

  @override
  Collection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Collection(
      id: fields[0] as String,
      itemIds: (fields[1] as List).cast<String>(),
      outfitIds: (fields[2] as List).cast<String>(),
      dateCreated: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Collection obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itemIds)
      ..writeByte(2)
      ..write(obj.outfitIds)
      ..writeByte(3)
      ..write(obj.dateCreated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionImpl _$$CollectionImplFromJson(Map<String, dynamic> json) =>
    _$CollectionImpl(
      id: json['id'] as String,
      itemIds:
          (json['itemIds'] as List<dynamic>).map((e) => e as String).toList(),
      outfitIds:
          (json['outfitIds'] as List<dynamic>).map((e) => e as String).toList(),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
    );

Map<String, dynamic> _$$CollectionImplToJson(_$CollectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemIds': instance.itemIds,
      'outfitIds': instance.outfitIds,
      'dateCreated': instance.dateCreated.toIso8601String(),
    };
