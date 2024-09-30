// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaveImpl _$$SaveImplFromJson(Map<String, dynamic> json) => _$SaveImpl(
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      icon: const IconDataConverter()
          .fromJson(json['icon'] as Map<String, dynamic>),
      color: const ColorConverter().fromJson((json['color'] as num).toInt()),
      dataTime: const DateTimeConverter().fromJson(json['dataTime'] as String),
      memo: json['memo'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
      deposit: json['deposit'] as bool? ?? true,
      status: $enumDecodeNullable(_$SaveStatusEnumMap, json['status']) ??
          SaveStatus.unUsed,
      usedAmount: (json['usedAmount'] as num?)?.toInt() ?? 0,
      remainingPercentage:
          (json['remainingPercentage'] as num?)?.toDouble() ?? 1.0,
      linkedDepositId: json['linkedDepositId'] as String?,
      linkedWithdrawals: (json['linkedWithdrawals'] as List<dynamic>?)
              ?.map((e) => Withdrawal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      salePercentage: (json['salePercentage'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$SaveImplToJson(_$SaveImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'icon': const IconDataConverter().toJson(instance.icon),
      'color': const ColorConverter().toJson(instance.color),
      'dataTime': const DateTimeConverter().toJson(instance.dataTime),
      'memo': instance.memo,
      'imageUrl': instance.imageUrl,
      'deposit': instance.deposit,
      'status': _$SaveStatusEnumMap[instance.status]!,
      'usedAmount': instance.usedAmount,
      'remainingPercentage': instance.remainingPercentage,
      'linkedDepositId': instance.linkedDepositId,
      'linkedWithdrawals':
          instance.linkedWithdrawals.map((e) => e.toJson()).toList(),
      'salePercentage': instance.salePercentage,
    };

const _$SaveStatusEnumMap = {
  SaveStatus.used: 'used',
  SaveStatus.inUse: 'inUse',
  SaveStatus.unUsed: 'unUsed',
};

_$WithdrawalImpl _$$WithdrawalImplFromJson(Map<String, dynamic> json) =>
    _$WithdrawalImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$$WithdrawalImplToJson(_$WithdrawalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
    };
