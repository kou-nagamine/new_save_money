// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Save {
  String get name => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  IconData get icon => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;
  String get dataTime => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  bool get payment => throw _privateConstructorUsedError;

  /// Create a copy of Save
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaveCopyWith<Save> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveCopyWith<$Res> {
  factory $SaveCopyWith(Save value, $Res Function(Save) then) =
      _$SaveCopyWithImpl<$Res, Save>;
  @useResult
  $Res call(
      {String name,
      int price,
      IconData icon,
      Color color,
      String dataTime,
      String memo,
      bool payment});
}

/// @nodoc
class _$SaveCopyWithImpl<$Res, $Val extends Save>
    implements $SaveCopyWith<$Res> {
  _$SaveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Save
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? price = null,
    Object? icon = null,
    Object? color = null,
    Object? dataTime = null,
    Object? memo = null,
    Object? payment = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      dataTime: null == dataTime
          ? _value.dataTime
          : dataTime // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      payment: null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaveImplCopyWith<$Res> implements $SaveCopyWith<$Res> {
  factory _$$SaveImplCopyWith(
          _$SaveImpl value, $Res Function(_$SaveImpl) then) =
      __$$SaveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int price,
      IconData icon,
      Color color,
      String dataTime,
      String memo,
      bool payment});
}

/// @nodoc
class __$$SaveImplCopyWithImpl<$Res>
    extends _$SaveCopyWithImpl<$Res, _$SaveImpl>
    implements _$$SaveImplCopyWith<$Res> {
  __$$SaveImplCopyWithImpl(_$SaveImpl _value, $Res Function(_$SaveImpl) _then)
      : super(_value, _then);

  /// Create a copy of Save
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? price = null,
    Object? icon = null,
    Object? color = null,
    Object? dataTime = null,
    Object? memo = null,
    Object? payment = null,
  }) {
    return _then(_$SaveImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      dataTime: null == dataTime
          ? _value.dataTime
          : dataTime // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      payment: null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SaveImpl implements _Save {
  const _$SaveImpl(
      {required this.name,
      required this.price,
      required this.icon,
      required this.color,
      required this.dataTime,
      required this.memo,
      this.payment = true});

  @override
  final String name;
  @override
  final int price;
  @override
  final IconData icon;
  @override
  final Color color;
  @override
  final String dataTime;
  @override
  final String memo;
  @override
  @JsonKey()
  final bool payment;

  @override
  String toString() {
    return 'Save(name: $name, price: $price, icon: $icon, color: $color, dataTime: $dataTime, memo: $memo, payment: $payment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.dataTime, dataTime) ||
                other.dataTime == dataTime) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.payment, payment) || other.payment == payment));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, price, icon, color, dataTime, memo, payment);

  /// Create a copy of Save
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveImplCopyWith<_$SaveImpl> get copyWith =>
      __$$SaveImplCopyWithImpl<_$SaveImpl>(this, _$identity);
}

abstract class _Save implements Save {
  const factory _Save(
      {required final String name,
      required final int price,
      required final IconData icon,
      required final Color color,
      required final String dataTime,
      required final String memo,
      final bool payment}) = _$SaveImpl;

  @override
  String get name;
  @override
  int get price;
  @override
  IconData get icon;
  @override
  Color get color;
  @override
  String get dataTime;
  @override
  String get memo;
  @override
  bool get payment;

  /// Create a copy of Save
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveImplCopyWith<_$SaveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
