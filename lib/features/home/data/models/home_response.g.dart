// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProviderProposalsResponseImpl _$$ProviderProposalsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProviderProposalsResponseImpl(
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => Projects.fromJson(e as Map<String, dynamic>))
          .toList(),
      current_page: json['current_page'] as int?,
      total: json['total'] as int?,
      have_project: json['have_project'] as bool?,
      slides:
          (json['slides'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ProviderProposalsResponseImplToJson(
        _$ProviderProposalsResponseImpl instance) =>
    <String, dynamic>{
      'projects': instance.projects,
      'current_page': instance.current_page,
      'total': instance.total,
      'have_project': instance.have_project,
      'slides': instance.slides,
    };

_$ProjectsImpl _$$ProjectsImplFromJson(Map<String, dynamic> json) =>
    _$ProjectsImpl(
      id: json['id'] as int?,
      distance_from_me: (json['distance_from_me'] as num?)?.toDouble(),
      status: json['status'] as String?,
      have_a_proposal: json['have_a_proposal'] as bool?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      location_lat: (json['location_lat'] as num?)?.toDouble(),
      location_lang: (json['location_lang'] as num?)?.toDouble(),
      equipment_cost: (json['equipment_cost'] as num?)?.toDouble() ?? 0,
      created_at: json['created_at'] as String?,
      available_time: json['available_time'] as String?,
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      attachment_audios: (json['attachment_audios'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachment_images: (json['attachment_images'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachments_videos: (json['attachments_videos'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProjectsImplToJson(_$ProjectsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'distance_from_me': instance.distance_from_me,
      'status': instance.status,
      'have_a_proposal': instance.have_a_proposal,
      'name': instance.name,
      'description': instance.description,
      'location_lat': instance.location_lat,
      'location_lang': instance.location_lang,
      'equipment_cost': instance.equipment_cost,
      'created_at': instance.created_at,
      'available_time': instance.available_time,
      'customer': instance.customer,
      'attachment_audios': instance.attachment_audios,
      'attachments': instance.attachments,
      'attachment_images': instance.attachment_images,
      'attachments_videos': instance.attachments_videos,
    };

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };

_$AttachmentImpl _$$AttachmentImplFromJson(Map<String, dynamic> json) =>
    _$AttachmentImpl(
      id: json['id'] as int?,
      url: json['url'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$AttachmentImplToJson(_$AttachmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'type': instance.type,
    };
