// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      c: (json['c'] as List<dynamic>?)?.map((e) => e as String).toList(),
      p: (json['p'] as num?)?.toDouble(),
      s: json['s'] as String?,
      t: (json['t'] as num?)?.toInt(),
      v: (json['v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'c': instance.c,
      'p': instance.p,
      's': instance.s,
      't': instance.t,
      'v': instance.v,
    };
