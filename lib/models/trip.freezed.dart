// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Trip _$TripFromJson(Map<String, dynamic> json) {
  return _Trip.fromJson(json);
}

/// @nodoc
mixin _$Trip {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get startDate => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get endDate => throw _privateConstructorUsedError;
  @HiveField(4)
  List<String> get itemIds => throw _privateConstructorUsedError;
  @HiveField(5)
  List<String> get outfitIds => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get destination => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TripCopyWith<Trip> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripCopyWith<$Res> {
  factory $TripCopyWith(Trip value, $Res Function(Trip) then) =
      _$TripCopyWithImpl<$Res, Trip>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) DateTime startDate,
      @HiveField(3) DateTime endDate,
      @HiveField(4) List<String> itemIds,
      @HiveField(5) List<String> outfitIds,
      @HiveField(6) String? destination,
      @HiveField(7) String? notes});
}

/// @nodoc
class _$TripCopyWithImpl<$Res, $Val extends Trip>
    implements $TripCopyWith<$Res> {
  _$TripCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? itemIds = null,
    Object? outfitIds = null,
    Object? destination = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      itemIds: null == itemIds
          ? _value.itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      outfitIds: null == outfitIds
          ? _value.outfitIds
          : outfitIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TripImplCopyWith<$Res> implements $TripCopyWith<$Res> {
  factory _$$TripImplCopyWith(
          _$TripImpl value, $Res Function(_$TripImpl) then) =
      __$$TripImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) DateTime startDate,
      @HiveField(3) DateTime endDate,
      @HiveField(4) List<String> itemIds,
      @HiveField(5) List<String> outfitIds,
      @HiveField(6) String? destination,
      @HiveField(7) String? notes});
}

/// @nodoc
class __$$TripImplCopyWithImpl<$Res>
    extends _$TripCopyWithImpl<$Res, _$TripImpl>
    implements _$$TripImplCopyWith<$Res> {
  __$$TripImplCopyWithImpl(_$TripImpl _value, $Res Function(_$TripImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? itemIds = null,
    Object? outfitIds = null,
    Object? destination = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$TripImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      itemIds: null == itemIds
          ? _value._itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      outfitIds: null == outfitIds
          ? _value._outfitIds
          : outfitIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripImpl implements _Trip {
  const _$TripImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.startDate,
      @HiveField(3) required this.endDate,
      @HiveField(4) required final List<String> itemIds,
      @HiveField(5) required final List<String> outfitIds,
      @HiveField(6) this.destination,
      @HiveField(7) this.notes})
      : _itemIds = itemIds,
        _outfitIds = outfitIds;

  factory _$TripImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final DateTime startDate;
  @override
  @HiveField(3)
  final DateTime endDate;
  final List<String> _itemIds;
  @override
  @HiveField(4)
  List<String> get itemIds {
    if (_itemIds is EqualUnmodifiableListView) return _itemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemIds);
  }

  final List<String> _outfitIds;
  @override
  @HiveField(5)
  List<String> get outfitIds {
    if (_outfitIds is EqualUnmodifiableListView) return _outfitIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outfitIds);
  }

  @override
  @HiveField(6)
  final String? destination;
  @override
  @HiveField(7)
  final String? notes;

  @override
  String toString() {
    return 'Trip(id: $id, name: $name, startDate: $startDate, endDate: $endDate, itemIds: $itemIds, outfitIds: $outfitIds, destination: $destination, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(other._itemIds, _itemIds) &&
            const DeepCollectionEquality()
                .equals(other._outfitIds, _outfitIds) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_itemIds),
      const DeepCollectionEquality().hash(_outfitIds),
      destination,
      notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      __$$TripImplCopyWithImpl<_$TripImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripImplToJson(
      this,
    );
  }
}

abstract class _Trip implements Trip {
  const factory _Trip(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final DateTime startDate,
      @HiveField(3) required final DateTime endDate,
      @HiveField(4) required final List<String> itemIds,
      @HiveField(5) required final List<String> outfitIds,
      @HiveField(6) final String? destination,
      @HiveField(7) final String? notes}) = _$TripImpl;

  factory _Trip.fromJson(Map<String, dynamic> json) = _$TripImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  DateTime get startDate;
  @override
  @HiveField(3)
  DateTime get endDate;
  @override
  @HiveField(4)
  List<String> get itemIds;
  @override
  @HiveField(5)
  List<String> get outfitIds;
  @override
  @HiveField(6)
  String? get destination;
  @override
  @HiveField(7)
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$TripImplCopyWith<_$TripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
