import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote.g.dart';

@JsonSerializable()
class Quote extends Equatable {
  @JsonKey(name: 'c')
  final double? currentPrice;
  @JsonKey(name: 'd')
  final double? change;
  @JsonKey(name: 'dp')
  final double? percentChange;
  @JsonKey(name: 'h')
  final double? highPriceOfTheDay;
  @JsonKey(name: 'l')
  final double? lowestPriceOfTheDay;
  @JsonKey(name: 'o')
  final double? openPriceOfTheDay;
  @JsonKey(name: 'pc')
  final double? previousClosePrice;
  final int? t;

  const Quote({
    this.currentPrice,
    this.change,
    this.percentChange,
    this.highPriceOfTheDay,
    this.lowestPriceOfTheDay,
    this.openPriceOfTheDay,
    this.previousClosePrice,
    this.t,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);

  Quote copyWith({
    double? currentPrice,
    double? change,
    double? percentChange,
    double? highPriceOfTheDay,
    double? lowestPriceOfTheDay,
    double? openPriceOfTheDay,
    double? previousClosePrice,
    int? t,
  }) {
    return Quote(
      currentPrice: currentPrice ?? this.currentPrice,
      change: change ?? this.change,
      percentChange: percentChange ?? this.percentChange,
      highPriceOfTheDay: highPriceOfTheDay ?? this.highPriceOfTheDay,
      lowestPriceOfTheDay: lowestPriceOfTheDay ?? this.lowestPriceOfTheDay,
      openPriceOfTheDay: openPriceOfTheDay ?? this.openPriceOfTheDay,
      previousClosePrice: previousClosePrice ?? this.previousClosePrice,
      t: t ?? this.t,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        currentPrice,
        change,
        percentChange,
        highPriceOfTheDay,
        lowestPriceOfTheDay,
        openPriceOfTheDay,
        previousClosePrice,
        t
      ];
}
