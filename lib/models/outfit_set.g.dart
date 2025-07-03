// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outfit_set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutfitSetAdapter extends TypeAdapter<OutfitSet> {
  @override
  final int typeId = 1;

  @override
  OutfitSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OutfitSet(
      id: fields[0] as String,
      name: fields[1] as String,
      itemIds: (fields[2] as List).cast<String>(),
      dateCreated: fields[3] as DateTime,
      notes: fields[4] as String?,
      tags: (fields[5] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, OutfitSet obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.itemIds)
      ..writeByte(3)
      ..write(obj.dateCreated)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutfitSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OutfitSetImpl _$$OutfitSetImplFromJson(Map<String, dynamic> json) =>
    _$OutfitSetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      itemIds:
          (json['itemIds'] as List<dynamic>).map((e) => e as String).toList(),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      notes: json['notes'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$OutfitSetImplToJson(_$OutfitSetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'itemIds': instance.itemIds,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'notes': instance.notes,
      'tags': instance.tags,
    };
