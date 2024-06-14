// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) => Stock(
      currency: json['currency'] as String?,
      description: json['description'] as String?,
      displaySymbol: json['displaySymbol'] as String?,
      figi: json['figi'] as String?,
      isin: json['isin'],
      mic: json['mic'] as String?,
      shareClassFigi: json['shareClassFIGI'] as String?,
      symbol: json['symbol'] as String?,
      symbol2: json['symbol2'] as String?,
      type: json['type'] as String?,
      priceAlert: (json['priceAlert'] as num?)?.toDouble(),
      quote: json['quote'] == null
          ? null
          : Quote.fromJson(json['quote'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockToJson(Stock instance) => <String, dynamic>{
      'currency': instance.currency,
      'description': instance.description,
      'displaySymbol': instance.displaySymbol,
      'figi': instance.figi,
      'isin': instance.isin,
      'mic': instance.mic,
      'shareClassFIGI': instance.shareClassFigi,
      'symbol': instance.symbol,
      'symbol2': instance.symbol2,
      'type': instance.type,
      'priceAlert': instance.priceAlert,
      'quote': instance.quote,
    };
