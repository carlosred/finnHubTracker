import 'package:equatable/equatable.dart';
import 'package:finnhub_project/domain/Models/quote/quote.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock.g.dart';

@JsonSerializable()
class Stock extends Equatable {
  final String? currency;
  final String? description;
  final String? displaySymbol;
  final String? figi;
  final dynamic isin;
  final String? mic;
  @JsonKey(name: 'shareClassFIGI')
  final String? shareClassFigi;
  final String? symbol;
  final String? symbol2;
  final String? type;
  final double? priceAlert;
  final Quote? quote;

  const Stock({
    this.currency,
    this.description,
    this.displaySymbol,
    this.figi,
    this.isin,
    this.mic,
    this.shareClassFigi,
    this.symbol,
    this.symbol2,
    this.type,
    this.priceAlert,
    this.quote,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);

  Stock copyWith({
    String? currency,
    String? description,
    String? displaySymbol,
    String? figi,
    dynamic isin,
    String? mic,
    String? shareClassFigi,
    String? symbol,
    String? symbol2,
    String? type,
    double? priceAlert,
    Quote? quote,
  }) {
    return Stock(
      currency: currency ?? this.currency,
      description: description ?? this.description,
      displaySymbol: displaySymbol ?? this.displaySymbol,
      figi: figi ?? this.figi,
      isin: isin ?? this.isin,
      mic: mic ?? this.mic,
      shareClassFigi: shareClassFigi ?? this.shareClassFigi,
      symbol: symbol ?? this.symbol,
      symbol2: symbol2 ?? this.symbol2,
      type: type ?? this.type,
      priceAlert: priceAlert ?? this.priceAlert,
      quote: quote ?? this.quote,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      currency,
      description,
      displaySymbol,
      figi,
      isin,
      mic,
      shareClassFigi,
      symbol,
      symbol2,
      type,
    ];
  }
}
