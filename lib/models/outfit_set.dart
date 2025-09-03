import 'package:freezed_annotation/freezed_annotation.dart';

part 'outfit_set.freezed.dart';
part 'outfit_set.g.dart';

@freezed
class OutfitSet with _$OutfitSet {
  const factory OutfitSet({
    required String id,
    required String name,
    required List<String> itemIds,
    required DateTime dateCreated,
    String? notes,
    List<String>? tags,
  }) = _OutfitSet;

  factory OutfitSet.fromJson(Map<String, dynamic> json) =>
      _$OutfitSetFromJson(json);
}
