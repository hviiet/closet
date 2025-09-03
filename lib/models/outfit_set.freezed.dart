// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outfit_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OutfitSet _$OutfitSetFromJson(Map<String, dynamic> json) {
  return _OutfitSet.fromJson(json);
}

/// @nodoc
mixin _$OutfitSet {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_ids')
  List<String> get itemIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_created')
  DateTime get dateCreated => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutfitSetCopyWith<OutfitSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutfitSetCopyWith<$Res> {
  factory $OutfitSetCopyWith(OutfitSet value, $Res Function(OutfitSet) then) =
      _$OutfitSetCopyWithImpl<$Res, OutfitSet>;
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'item_ids') List<String> itemIds,
      @JsonKey(name: 'date_created') DateTime dateCreated,
      String? notes,
      List<String>? tags});
}

/// @nodoc
class _$OutfitSetCopyWithImpl<$Res, $Val extends OutfitSet>
    implements $OutfitSetCopyWith<$Res> {
  _$OutfitSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? itemIds = null,
    Object? dateCreated = null,
    Object? notes = freezed,
    Object? tags = freezed,
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
      itemIds: null == itemIds
          ? _value.itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutfitSetImplCopyWith<$Res>
    implements $OutfitSetCopyWith<$Res> {
  factory _$$OutfitSetImplCopyWith(
          _$OutfitSetImpl value, $Res Function(_$OutfitSetImpl) then) =
      __$$OutfitSetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'item_ids') List<String> itemIds,
      @JsonKey(name: 'date_created') DateTime dateCreated,
      String? notes,
      List<String>? tags});
}

/// @nodoc
class __$$OutfitSetImplCopyWithImpl<$Res>
    extends _$OutfitSetCopyWithImpl<$Res, _$OutfitSetImpl>
    implements _$$OutfitSetImplCopyWith<$Res> {
  __$$OutfitSetImplCopyWithImpl(
      _$OutfitSetImpl _value, $Res Function(_$OutfitSetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? itemIds = null,
    Object? dateCreated = null,
    Object? notes = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$OutfitSetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      itemIds: null == itemIds
          ? _value._itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutfitSetImpl implements _OutfitSet {
  const _$OutfitSetImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'item_ids') required final List<String> itemIds,
      @JsonKey(name: 'date_created') required this.dateCreated,
      this.notes,
      final List<String>? tags})
      : _itemIds = itemIds,
        _tags = tags;

  factory _$OutfitSetImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutfitSetImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _itemIds;
  @override
  @JsonKey(name: 'item_ids')
  List<String> get itemIds {
    if (_itemIds is EqualUnmodifiableListView) return _itemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemIds);
  }

  @override
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;
  @override
  final String? notes;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'OutfitSet(id: $id, name: $name, itemIds: $itemIds, dateCreated: $dateCreated, notes: $notes, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutfitSetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._itemIds, _itemIds) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_itemIds),
      dateCreated,
      notes,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OutfitSetImplCopyWith<_$OutfitSetImpl> get copyWith =>
      __$$OutfitSetImplCopyWithImpl<_$OutfitSetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutfitSetImplToJson(
      this,
    );
  }
}

abstract class _OutfitSet implements OutfitSet {
  const factory _OutfitSet(
      {required final String id,
      required final String name,
      @JsonKey(name: 'item_ids') required final List<String> itemIds,
      @JsonKey(name: 'date_created') required final DateTime dateCreated,
      final String? notes,
      final List<String>? tags}) = _$OutfitSetImpl;

  factory _OutfitSet.fromJson(Map<String, dynamic> json) =
      _$OutfitSetImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'item_ids')
  List<String> get itemIds;
  @override
  @JsonKey(name: 'date_created')
  DateTime get dateCreated;
  @override
  String? get notes;
  @override
  List<String>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$OutfitSetImplCopyWith<_$OutfitSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
