// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      name: json['name'] as String?,
      id: json['id'] as int?,
      avg_rate: (json['avg_rate'] as num?)?.toDouble(),
      phone: json['phone'] as String?,
      identity_image: json['identity_image'] as String?,
      personal_image: json['personal_image'] as String?,
      type_resident: json['type_resident'] as String?,
      iban_number: json['iban_number'] as String?,
      stcpay_number: json['stcpay_number'] as String?,
      status: json['status'] as String?,
      active: json['active'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      completed_projects: json['completed_projects'] as int?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'avg_rate': instance.avg_rate,
      'phone': instance.phone,
      'identity_image': instance.identity_image,
      'personal_image': instance.personal_image,
      'type_resident': instance.type_resident,
      'iban_number': instance.iban_number,
      'stcpay_number': instance.stcpay_number,
      'status': instance.status,
      'active': instance.active,
      'balance': instance.balance,
      'completed_projects': instance.completed_projects,
    };

_$ServiceImpl _$$ServiceImplFromJson(Map<String, dynamic> json) =>
    _$ServiceImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      created_at: json['created_at'] as String?,
      icon: json['icon'] == null
          ? null
          : ServiceIcon.fromJson(json['icon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ServiceImplToJson(_$ServiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'created_at': instance.created_at,
      'icon': instance.icon,
    };

_$ServicesResponseImpl _$$ServicesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ServicesResponseImpl(
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ServicesResponseImplToJson(
        _$ServicesResponseImpl instance) =>
    <String, dynamic>{
      'services': instance.services,
    };

_$ServiceIconImpl _$$ServiceIconImplFromJson(Map<String, dynamic> json) =>
    _$ServiceIconImpl(
      id: json['id'] as int?,
      url: json['url'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$ServiceIconImplToJson(_$ServiceIconImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'type': instance.type,
    };
