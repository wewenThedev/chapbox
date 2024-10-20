// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      infos: json['infos'] as String?,
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'infos': instance.infos,
    };
