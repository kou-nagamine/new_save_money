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

Save _$SaveFromJson(Map<String, dynamic> json) {
  return _Save.fromJson(json);
}

/// @nodoc
mixin _$Save {
  String get name => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  @IconDataConverter()
  IconData get icon => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get color => throw _privateConstructorUsedError;
  String get dataTime => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  bool get deposit => throw _privateConstructorUsedError;
  SaveStatus get status => throw _privateConstructorUsedError; // 状態を示すプロパティを追加
  int get usedAmount =>
      throw _privateConstructorUsedError; // 使用された金額を追跡するプロパティを追加
  double get remainingPercentage => throw _privateConstructorUsedError;

  /// Serializes this Save to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

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
      @IconDataConverter() IconData icon,
      @ColorConverter() Color color,
      String dataTime,
      String memo,
      bool deposit,
      SaveStatus status,
      int usedAmount,
      double remainingPercentage});
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
    Object? deposit = null,
    Object? status = null,
    Object? usedAmount = null,
    Object? remainingPercentage = null,
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
      deposit: null == deposit
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SaveStatus,
      usedAmount: null == usedAmount
          ? _value.usedAmount
          : usedAmount // ignore: cast_nullable_to_non_nullable
              as int,
      remainingPercentage: null == remainingPercentage
          ? _value.remainingPercentage
          : remainingPercentage // ignore: cast_nullable_to_non_nullable
              as double,
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
      @IconDataConverter() IconData icon,
      @ColorConverter() Color color,
      String dataTime,
      String memo,
      bool deposit,
      SaveStatus status,
      int usedAmount,
      double remainingPercentage});
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
    Object? deposit = null,
    Object? status = null,
    Object? usedAmount = null,
    Object? remainingPercentage = null,
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
      deposit: null == deposit
          ? _value.deposit
          : deposit // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SaveStatus,
      usedAmount: null == usedAmount
          ? _value.usedAmount
          : usedAmount // ignore: cast_nullable_to_non_nullable
              as int,
      remainingPercentage: null == remainingPercentage
          ? _value.remainingPercentage
          : remainingPercentage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SaveImpl implements _Save {
  const _$SaveImpl(
      {required this.name,
      required this.price,
      @IconDataConverter() required this.icon,
      @ColorConverter() required this.color,
      required this.dataTime,
      required this.memo,
      this.deposit = true,
      this.status = SaveStatus.unUsed,
      this.usedAmount = 0,
      this.remainingPercentage = 1.0});

  factory _$SaveImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaveImplFromJson(json);

  @override
  final String name;
  @override
  final int price;
  @override
  @IconDataConverter()
  final IconData icon;
  @override
  @ColorConverter()
  final Color color;
  @override
  final String dataTime;
  @override
  final String memo;
  @override
  @JsonKey()
  final bool deposit;
  @override
  @JsonKey()
  final SaveStatus status;
// 状態を示すプロパティを追加
  @override
  @JsonKey()
  final int usedAmount;
// 使用された金額を追跡するプロパティを追加
  @override
  @JsonKey()
  final double remainingPercentage;

  @override
  String toString() {
    return 'Save(name: $name, price: $price, icon: $icon, color: $color, dataTime: $dataTime, memo: $memo, deposit: $deposit, status: $status, usedAmount: $usedAmount, remainingPercentage: $remainingPercentage)';
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
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.usedAmount, usedAmount) ||
                other.usedAmount == usedAmount) &&
            (identical(other.remainingPercentage, remainingPercentage) ||
                other.remainingPercentage == remainingPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, price, icon, color,
      dataTime, memo, deposit, status, usedAmount, remainingPercentage);

  /// Create a copy of Save
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveImplCopyWith<_$SaveImpl> get copyWith =>
      __$$SaveImplCopyWithImpl<_$SaveImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaveImplToJson(
      this,
    );
  }
}

abstract class _Save implements Save {
  const factory _Save(
      {required final String name,
      required final int price,
      @IconDataConverter() required final IconData icon,
      @ColorConverter() required final Color color,
      required final String dataTime,
      required final String memo,
      final bool deposit,
      final SaveStatus status,
      final int usedAmount,
      final double remainingPercentage}) = _$SaveImpl;

  factory _Save.fromJson(Map<String, dynamic> json) = _$SaveImpl.fromJson;

  @override
  String get name;
  @override
  int get price;
  @override
  @IconDataConverter()
  IconData get icon;
  @override
  @ColorConverter()
  Color get color;
  @override
  String get dataTime;
  @override
  String get memo;
  @override
  bool get deposit;
  @override
  SaveStatus get status; // 状態を示すプロパティを追加
  @override
  int get usedAmount; // 使用された金額を追跡するプロパティを追加
  @override
  double get remainingPercentage;

  /// Create a copy of Save
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveImplCopyWith<_$SaveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
