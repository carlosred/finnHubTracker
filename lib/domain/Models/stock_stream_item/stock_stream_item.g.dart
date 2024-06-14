// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_stream_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockStreamItem _$StockStreamItemFromJson(Map<String, dynamic> json) =>
    StockStreamItem(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$StockStreamItemToJson(StockStreamItem instance) =>
    <String, dynamic>{
      'data': instance.data,
      'type': instance.type,
    };
