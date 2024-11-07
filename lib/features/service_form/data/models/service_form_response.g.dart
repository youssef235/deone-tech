// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_form_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceFormResponseImpl _$$ServiceFormResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceFormResponseImpl(
      districts: (json['districts'] as List<dynamic>?)
          ?.map((e) => District.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ServiceFormResponseImplToJson(
        _$ServiceFormResponseImpl instance) =>
    <String, dynamic>{
      'districts': instance.districts,
    };

_$DistrictImpl _$$DistrictImplFromJson(Map<String, dynamic> json) =>
    _$DistrictImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$DistrictImplToJson(_$DistrictImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
