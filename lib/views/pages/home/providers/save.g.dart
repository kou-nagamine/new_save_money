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
      dataTime: json['dataTime'] as String,
      memo: json['memo'] as String,
      deposit: json['deposit'] as bool? ?? true,
    );

Map<String, dynamic> _$$SaveImplToJson(_$SaveImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'icon': const IconDataConverter().toJson(instance.icon),
      'color': const ColorConverter().toJson(instance.color),
      'dataTime': instance.dataTime,
      'memo': instance.memo,
      'deposit': instance.deposit,
    };
