import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

@freezed
@HiveType(typeId: 2)
class Trip with _$Trip {
  const factory Trip({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required DateTime startDate,
    @HiveField(3) required DateTime endDate,
    @HiveField(4) required List<String> itemIds,
    @HiveField(5) required List<String> outfitIds,
    @HiveField(6) String? destination,
    @HiveField(7) String? notes,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}
