import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

@freezed
@HiveType(typeId: 2)
class Trip with _$Trip {
  const factory Trip({
    @HiveField(0) required String id,
    @HiveField(1) required List<String> itemIds,
    @HiveField(2) required List<String> outfitIds,
    @HiveField(3) required DateTime dateCreated,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}
