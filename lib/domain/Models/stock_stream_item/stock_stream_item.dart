import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'stock_stream_item.g.dart';

@JsonSerializable()
class StockStreamItem extends Equatable {
  final List<Datum>? data;
  final String? type;

  const StockStreamItem({this.data, this.type});

  factory StockStreamItem.fromJson(Map<String, dynamic> json) {
    return _$StockStreamItemFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StockStreamItemToJson(this);

  StockStreamItem copyWith({
    List<Datum>? data,
    String? type,
  }) {
    return StockStreamItem(
      data: data ?? this.data,
      type: type ?? this.type,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [data, type];
}
