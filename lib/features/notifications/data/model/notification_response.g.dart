// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationsResponseImpl _$$NotificationsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationsResponseImpl(
      proposals: (json['proposals'] as List<dynamic>?)
          ?.map((e) => Proposals.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NotificationsResponseImplToJson(
        _$NotificationsResponseImpl instance) =>
    <String, dynamic>{
      'proposals': instance.proposals,
    };

_$ProposalsImpl _$$ProposalsImplFromJson(Map<String, dynamic> json) =>
    _$ProposalsImpl(
      id: json['id'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      original_price: (json['original_price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      project: json['project'] == null
          ? null
          : Projects.fromJson(json['project'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : Customers.fromJson(json['customer'] as Map<String, dynamic>),
      status: json['status'] as String?,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$$ProposalsImplToJson(_$ProposalsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'original_price': instance.original_price,
      'description': instance.description,
      'project': instance.project,
      'customer': instance.customer,
      'status': instance.status,
      'created_at': instance.created_at,
    };

_$CustomersImpl _$$CustomersImplFromJson(Map<String, dynamic> json) =>
    _$CustomersImpl(
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      firebase_token: json['firebase_token'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$$CustomersImplToJson(_$CustomersImpl instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'name': instance.name,
      'firebase_token': instance.firebase_token,
      'id': instance.id,
    };

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      location_lat: (json['location_lat'] as num?)?.toDouble(),
      location_lang: (json['location_lang'] as num?)?.toDouble(),
      status: json['status'] as String?,
      selected_me: json['selected_me'] as bool?,
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location_lat': instance.location_lat,
      'location_lang': instance.location_lang,
      'status': instance.status,
      'selected_me': instance.selected_me,
    };
