// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Collection _$CollectionFromJson(Map<String, dynamic> json) {
  return _Collection.fromJson(json);
}

/// @nodoc
mixin _$Collection {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_ids')
  List<String> get itemIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'outfit_ids')
  List<String> get outfitIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_created')
  DateTime get dateCreated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CollectionCopyWith<Collection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionCopyWith<$Res> {
  factory $CollectionCopyWith(
          Collection value, $Res Function(Collection) then) =
      _$CollectionCopyWithImpl<$Res, Collection>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'item_ids') List<String> itemIds,
      @JsonKey(name: 'outfit_ids') List<String> outfitIds,
      @JsonKey(name: 'date_created') DateTime dateCreated});
}

/// @nodoc
class _$CollectionCopyWithImpl<$Res, $Val extends Collection>
    implements $CollectionCopyWith<$Res> {
  _$CollectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemIds = null,
    Object? outfitIds = null,
    Object? dateCreated = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      itemIds: null == itemIds
          ? _value.itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      outfitIds: null == outfitIds
          ? _value.outfitIds
          : outfitIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollectionImplCopyWith<$Res>
    implements $CollectionCopyWith<$Res> {
  factory _$$CollectionImplCopyWith(
          _$CollectionImpl value, $Res Function(_$CollectionImpl) then) =
      __$$CollectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'item_ids') List<String> itemIds,
      @JsonKey(name: 'outfit_ids') List<String> outfitIds,
      @JsonKey(name: 'date_created') DateTime dateCreated});
}

/// @nodoc
class __$$CollectionImplCopyWithImpl<$Res>
    extends _$CollectionCopyWithImpl<$Res, _$CollectionImpl>
    implements _$$CollectionImplCopyWith<$Res> {
  __$$CollectionImplCopyWithImpl(
      _$CollectionImpl _value, $Res Function(_$CollectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemIds = null,
    Object? outfitIds = null,
    Object? dateCreated = null,
  }) {
    return _then(_$CollectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      itemIds: null == itemIds
          ? _value._itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      outfitIds: null == outfitIds
          ? _value._outfitIds
          : outfitIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionImpl implements _Collection {
  const _$CollectionImpl(
      {required this.id,
      @JsonKey(name: 'item_ids') required final List<String> itemIds,
      @JsonKey(name: 'outfit_ids') required final List<String> outfitIds,
      @JsonKey(name: 'date_created') required this.dateCreated})
      : _itemIds = itemIds,
        _outfitIds = outfitIds;

  factory _$CollectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionImplFromJson(json);

  @override
  final String id;
  final List<String> _itemIds;
  @override
  @JsonKey(name: 'item_ids')
  List<String> get itemIds {
    if (_itemIds is EqualUnmodifiableListView) return _itemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemIds);
  }

  final List<String> _outfitIds;
  @override
  @JsonKey(name: 'outfit_ids')
  List<String> get outfitIds {
    if (_outfitIds is EqualUnmodifiableListView) return _outfitIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outfitIds);
  }

  @override
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;

  @override
  String toString() {
    return 'Collection(id: $id, itemIds: $itemIds, outfitIds: $outfitIds, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._itemIds, _itemIds) &&
            const DeepCollectionEquality()
                .equals(other._outfitIds, _outfitIds) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_itemIds),
      const DeepCollectionEquality().hash(_outfitIds),
      dateCreated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionImplCopyWith<_$CollectionImpl> get copyWith =>
      __$$CollectionImplCopyWithImpl<_$CollectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionImplToJson(
      this,
    );
  }
}

abstract class _Collection implements Collection {
  const factory _Collection(
          {required final String id,
          @JsonKey(name: 'item_ids') required final List<String> itemIds,
          @JsonKey(name: 'outfit_ids') required final List<String> outfitIds,
          @JsonKey(name: 'date_created') required final DateTime dateCreated}) =
      _$CollectionImpl;

  factory _Collection.fromJson(Map<String, dynamic> json) =
      _$CollectionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'item_ids')
  List<String> get itemIds;
  @override
  @JsonKey(name: 'outfit_ids')
  List<String> get outfitIds;
  @override
  @JsonKey(name: 'date_created')
  DateTime get dateCreated;
  @override
  @JsonKey(ignore: true)
  _$$CollectionImplCopyWith<_$CollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
