// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supermarket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supermarket _$SupermarketFromJson(Map<String, dynamic> json) => Supermarket(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      denomination: json['denomination'] as String?,
      rccm: json['rccm'] as String?,
      ifu: json['ifu'] as String?,
      website: json['website'] as String?,
      addressId: (json['address_id'] as num).toInt(),
      logoId: (json['logo_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SupermarketToJson(Supermarket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.denomination case final value?) 'denomination': value,
      if (instance.rccm case final value?) 'rccm': value,
      if (instance.ifu case final value?) 'ifu': value,
      if (instance.website case final value?) 'website': value,
      'address_id': instance.addressId,
      if (instance.logoId case final value?) 'logo_id': value,
    };
