import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum extends Equatable {
  final List<String>? c;
  final double? p;
  final String? s;
  final int? t;
  final int? v;

  const Datum({this.c, this.p, this.s, this.t, this.v});

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

  Datum copyWith({
    List<String>? c,
    double? p,
    String? s,
    int? t,
    int? v,
  }) {
    return Datum(
      c: c ?? this.c,
      p: p ?? this.p,
      s: s ?? this.s,
      t: t ?? this.t,
      v: v ?? this.v,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [c, p, s, t, v];
}
