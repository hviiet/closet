import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'collection.freezed.dart';
part 'collection.g.dart';

@freezed
@HiveType(typeId: 2)
class Collection with _$Collection {
  const factory Collection({
    @HiveField(0) required String id,
    @HiveField(1) required List<String> itemIds,
    @HiveField(2) required List<String> outfitIds,
    @HiveField(3) required DateTime dateCreated,
  }) = _Collection;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
}
