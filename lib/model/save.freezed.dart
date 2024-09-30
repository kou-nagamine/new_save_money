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
  @DateTimeConverter()
  DateTime get dataTime =>
      throw _privateConstructorUsedError; // DateTimeConverterを適用
  String get memo => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError; // デフォルト値を設定
  bool get deposit => throw _privateConstructorUsedError;
  SaveStatus get status => throw _privateConstructorUsedError; // 状態を示すプロパティを追加
  int get usedAmount =>
      throw _privateConstructorUsedError; // 使用された金額を追跡するプロパティを追加
  double get remainingPercentage =>
      throw _privateConstructorUsedError; // 残りの割合を追跡するプロパティを追加
  String? get linkedDepositId =>
      throw _privateConstructorUsedError; //入金と出金を紐づけられるための出金につけられるID
  List<Withdrawal> get linkedWithdrawals => throw _privateConstructorUsedError;
  double? get salePercentage => throw _privateConstructorUsedError;

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
      @DateTimeConverter() DateTime dataTime,
      String memo,
      String imageUrl,
      bool deposit,
      SaveStatus status,
      int usedAmount,
      double remainingPercentage,
      String? linkedDepositId,
      List<Withdrawal> linkedWithdrawals,
      double? salePercentage});
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
    Object? imageUrl = null,
    Object? deposit = null,
    Object? status = null,
    Object? usedAmount = null,
    Object? remainingPercentage = null,
    Object? linkedDepositId = freezed,
    Object? linkedWithdrawals = null,
    Object? salePercentage = freezed,
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
              as DateTime,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
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
      linkedDepositId: freezed == linkedDepositId
          ? _value.linkedDepositId
          : linkedDepositId // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedWithdrawals: null == linkedWithdrawals
          ? _value.linkedWithdrawals
          : linkedWithdrawals // ignore: cast_nullable_to_non_nullable
              as List<Withdrawal>,
      salePercentage: freezed == salePercentage
          ? _value.salePercentage
          : salePercentage // ignore: cast_nullable_to_non_nullable
              as double?,
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
      @DateTimeConverter() DateTime dataTime,
      String memo,
      String imageUrl,
      bool deposit,
      SaveStatus status,
      int usedAmount,
      double remainingPercentage,
      String? linkedDepositId,
      List<Withdrawal> linkedWithdrawals,
      double? salePercentage});
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
    Object? imageUrl = null,
    Object? deposit = null,
    Object? status = null,
    Object? usedAmount = null,
    Object? remainingPercentage = null,
    Object? linkedDepositId = freezed,
    Object? linkedWithdrawals = null,
    Object? salePercentage = freezed,
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
              as DateTime,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
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
      linkedDepositId: freezed == linkedDepositId
          ? _value.linkedDepositId
          : linkedDepositId // ignore: cast_nullable_to_non_nullable
              as String?,
      linkedWithdrawals: null == linkedWithdrawals
          ? _value._linkedWithdrawals
          : linkedWithdrawals // ignore: cast_nullable_to_non_nullable
              as List<Withdrawal>,
      salePercentage: freezed == salePercentage
          ? _value.salePercentage
          : salePercentage // ignore: cast_nullable_to_non_nullable
              as double?,
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
      @DateTimeConverter() required this.dataTime,
      required this.memo,
      this.imageUrl = '',
      this.deposit = true,
      this.status = SaveStatus.unUsed,
      this.usedAmount = 0,
      this.remainingPercentage = 1.0,
      this.linkedDepositId,
      final List<Withdrawal> linkedWithdrawals = const [],
      this.salePercentage = 0.0})
      : _linkedWithdrawals = linkedWithdrawals;

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
  @DateTimeConverter()
  final DateTime dataTime;
// DateTimeConverterを適用
  @override
  final String memo;
  @override
  @JsonKey()
  final String imageUrl;
// デフォルト値を設定
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
// 残りの割合を追跡するプロパティを追加
  @override
  final String? linkedDepositId;
//入金と出金を紐づけられるための出金につけられるID
  final List<Withdrawal> _linkedWithdrawals;
//入金と出金を紐づけられるための出金につけられるID
  @override
  @JsonKey()
  List<Withdrawal> get linkedWithdrawals {
    if (_linkedWithdrawals is EqualUnmodifiableListView)
      return _linkedWithdrawals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_linkedWithdrawals);
  }

  @override
  @JsonKey()
  final double? salePercentage;

  @override
  String toString() {
    return 'Save(name: $name, price: $price, icon: $icon, color: $color, dataTime: $dataTime, memo: $memo, imageUrl: $imageUrl, deposit: $deposit, status: $status, usedAmount: $usedAmount, remainingPercentage: $remainingPercentage, linkedDepositId: $linkedDepositId, linkedWithdrawals: $linkedWithdrawals, salePercentage: $salePercentage)';
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
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.deposit, deposit) || other.deposit == deposit) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.usedAmount, usedAmount) ||
                other.usedAmount == usedAmount) &&
            (identical(other.remainingPercentage, remainingPercentage) ||
                other.remainingPercentage == remainingPercentage) &&
            (identical(other.linkedDepositId, linkedDepositId) ||
                other.linkedDepositId == linkedDepositId) &&
            const DeepCollectionEquality()
                .equals(other._linkedWithdrawals, _linkedWithdrawals) &&
            (identical(other.salePercentage, salePercentage) ||
                other.salePercentage == salePercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      price,
      icon,
      color,
      dataTime,
      memo,
      imageUrl,
      deposit,
      status,
      usedAmount,
      remainingPercentage,
      linkedDepositId,
      const DeepCollectionEquality().hash(_linkedWithdrawals),
      salePercentage);

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
      @DateTimeConverter() required final DateTime dataTime,
      required final String memo,
      final String imageUrl,
      final bool deposit,
      final SaveStatus status,
      final int usedAmount,
      final double remainingPercentage,
      final String? linkedDepositId,
      final List<Withdrawal> linkedWithdrawals,
      final double? salePercentage}) = _$SaveImpl;

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
  @DateTimeConverter()
  DateTime get dataTime; // DateTimeConverterを適用
  @override
  String get memo;
  @override
  String get imageUrl; // デフォルト値を設定
  @override
  bool get deposit;
  @override
  SaveStatus get status; // 状態を示すプロパティを追加
  @override
  int get usedAmount; // 使用された金額を追跡するプロパティを追加
  @override
  double get remainingPercentage; // 残りの割合を追跡するプロパティを追加
  @override
  String? get linkedDepositId; //入金と出金を紐づけられるための出金につけられるID
  @override
  List<Withdrawal> get linkedWithdrawals;
  @override
  double? get salePercentage;

  /// Create a copy of Save
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveImplCopyWith<_$SaveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Withdrawal _$WithdrawalFromJson(Map<String, dynamic> json) {
  return _Withdrawal.fromJson(json);
}

/// @nodoc
mixin _$Withdrawal {
  String get id => throw _privateConstructorUsedError; //　ある出金で使われた入金につけられるID
  int get amount => throw _privateConstructorUsedError;

  /// Serializes this Withdrawal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Withdrawal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WithdrawalCopyWith<Withdrawal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawalCopyWith<$Res> {
  factory $WithdrawalCopyWith(
          Withdrawal value, $Res Function(Withdrawal) then) =
      _$WithdrawalCopyWithImpl<$Res, Withdrawal>;
  @useResult
  $Res call({String id, int amount});
}

/// @nodoc
class _$WithdrawalCopyWithImpl<$Res, $Val extends Withdrawal>
    implements $WithdrawalCopyWith<$Res> {
  _$WithdrawalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Withdrawal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WithdrawalImplCopyWith<$Res>
    implements $WithdrawalCopyWith<$Res> {
  factory _$$WithdrawalImplCopyWith(
          _$WithdrawalImpl value, $Res Function(_$WithdrawalImpl) then) =
      __$$WithdrawalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int amount});
}

/// @nodoc
class __$$WithdrawalImplCopyWithImpl<$Res>
    extends _$WithdrawalCopyWithImpl<$Res, _$WithdrawalImpl>
    implements _$$WithdrawalImplCopyWith<$Res> {
  __$$WithdrawalImplCopyWithImpl(
      _$WithdrawalImpl _value, $Res Function(_$WithdrawalImpl) _then)
      : super(_value, _then);

  /// Create a copy of Withdrawal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
  }) {
    return _then(_$WithdrawalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawalImpl implements _Withdrawal {
  const _$WithdrawalImpl({required this.id, required this.amount});

  factory _$WithdrawalImpl.fromJson(Map<String, dynamic> json) =>
      _$$WithdrawalImplFromJson(json);

  @override
  final String id;
//　ある出金で使われた入金につけられるID
  @override
  final int amount;

  @override
  String toString() {
    return 'Withdrawal(id: $id, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WithdrawalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount);

  /// Create a copy of Withdrawal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawalImplCopyWith<_$WithdrawalImpl> get copyWith =>
      __$$WithdrawalImplCopyWithImpl<_$WithdrawalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawalImplToJson(
      this,
    );
  }
}

abstract class _Withdrawal implements Withdrawal {
  const factory _Withdrawal(
      {required final String id, required final int amount}) = _$WithdrawalImpl;

  factory _Withdrawal.fromJson(Map<String, dynamic> json) =
      _$WithdrawalImpl.fromJson;

  @override
  String get id; //　ある出金で使われた入金につけられるID
  @override
  int get amount;

  /// Create a copy of Withdrawal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WithdrawalImplCopyWith<_$WithdrawalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
