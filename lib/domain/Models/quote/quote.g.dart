// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
      currentPrice: (json['c'] as num?)?.toDouble(),
      change: (json['d'] as num?)?.toDouble(),
      percentChange: (json['dp'] as num?)?.toDouble(),
      highPriceOfTheDay: (json['h'] as num?)?.toDouble(),
      lowestPriceOfTheDay: (json['l'] as num?)?.toDouble(),
      openPriceOfTheDay: (json['o'] as num?)?.toDouble(),
      previousClosePrice: (json['pc'] as num?)?.toDouble(),
      t: (json['t'] as num?)?.toInt(),
    );

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
      'c': instance.currentPrice,
      'd': instance.change,
      'dp': instance.percentChange,
      'h': instance.highPriceOfTheDay,
      'l': instance.lowestPriceOfTheDay,
      'o': instance.openPriceOfTheDay,
      'pc': instance.previousClosePrice,
      't': instance.t,
    };
