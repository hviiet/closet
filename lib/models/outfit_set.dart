import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'outfit_set.freezed.dart';
part 'outfit_set.g.dart';

@freezed
@HiveType(typeId: 1)
class OutfitSet with _$OutfitSet {
  const factory OutfitSet({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required List<String> itemIds,
    @HiveField(3) required DateTime dateCreated,
    @HiveField(4) String? notes,
    @HiveField(5) List<String>? tags,
  }) = _OutfitSet;

  factory OutfitSet.fromJson(Map<String, dynamic> json) =>
      _$OutfitSetFromJson(json);
}
