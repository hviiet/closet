// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clothing_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClothingItem _$ClothingItemFromJson(Map<String, dynamic> json) {
  return _ClothingItem.fromJson(json);
}

/// @nodoc
mixin _$ClothingItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_path')
  String get imagePath => throw _privateConstructorUsedError;
  ClothingCategory get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_added')
  DateTime get dateAdded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClothingItemCopyWith<ClothingItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClothingItemCopyWith<$Res> {
  factory $ClothingItemCopyWith(
          ClothingItem value, $Res Function(ClothingItem) then) =
      _$ClothingItemCopyWithImpl<$Res, ClothingItem>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'image_path') String imagePath,
      ClothingCategory category,
      @JsonKey(name: 'date_added') DateTime dateAdded});
}

/// @nodoc
class _$ClothingItemCopyWithImpl<$Res, $Val extends ClothingItem>
    implements $ClothingItemCopyWith<$Res> {
  _$ClothingItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imagePath = null,
    Object? category = null,
    Object? dateAdded = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ClothingCategory,
      dateAdded: null == dateAdded
          ? _value.dateAdded
          : dateAdded // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClothingItemImplCopyWith<$Res>
    implements $ClothingItemCopyWith<$Res> {
  factory _$$ClothingItemImplCopyWith(
          _$ClothingItemImpl value, $Res Function(_$ClothingItemImpl) then) =
      __$$ClothingItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'image_path') String imagePath,
      ClothingCategory category,
      @JsonKey(name: 'date_added') DateTime dateAdded});
}

/// @nodoc
class __$$ClothingItemImplCopyWithImpl<$Res>
    extends _$ClothingItemCopyWithImpl<$Res, _$ClothingItemImpl>
    implements _$$ClothingItemImplCopyWith<$Res> {
  __$$ClothingItemImplCopyWithImpl(
      _$ClothingItemImpl _value, $Res Function(_$ClothingItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imagePath = null,
    Object? category = null,
    Object? dateAdded = null,
  }) {
    return _then(_$ClothingItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ClothingCategory,
      dateAdded: null == dateAdded
          ? _value.dateAdded
          : dateAdded // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClothingItemImpl implements _ClothingItem {
  const _$ClothingItemImpl(
      {required this.id,
      @JsonKey(name: 'image_path') required this.imagePath,
      required this.category,
      @JsonKey(name: 'date_added') required this.dateAdded});

  factory _$ClothingItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClothingItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'image_path')
  final String imagePath;
  @override
  final ClothingCategory category;
  @override
  @JsonKey(name: 'date_added')
  final DateTime dateAdded;

  @override
  String toString() {
    return 'ClothingItem(id: $id, imagePath: $imagePath, category: $category, dateAdded: $dateAdded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClothingItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.dateAdded, dateAdded) ||
                other.dateAdded == dateAdded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, imagePath, category, dateAdded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClothingItemImplCopyWith<_$ClothingItemImpl> get copyWith =>
      __$$ClothingItemImplCopyWithImpl<_$ClothingItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClothingItemImplToJson(
      this,
    );
  }
}

abstract class _ClothingItem implements ClothingItem {
  const factory _ClothingItem(
          {required final String id,
          @JsonKey(name: 'image_path') required final String imagePath,
          required final ClothingCategory category,
          @JsonKey(name: 'date_added') required final DateTime dateAdded}) =
      _$ClothingItemImpl;

  factory _ClothingItem.fromJson(Map<String, dynamic> json) =
      _$ClothingItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'image_path')
  String get imagePath;
  @override
  ClothingCategory get category;
  @override
  @JsonKey(name: 'date_added')
  DateTime get dateAdded;
  @override
  @JsonKey(ignore: true)
  _$$ClothingItemImplCopyWith<_$ClothingItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
