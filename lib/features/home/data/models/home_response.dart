import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'home_response.freezed.dart';
part 'home_response.g.dart';

ProviderProposalsResponse homeResponseFromJson(String str) =>
    ProviderProposalsResponse.fromJson(json.decode(str));

String homeResponseToJson(ProviderProposalsResponse data) =>
    json.encode(data.toJson());

@freezed
class ProviderProposalsResponse with _$ProviderProposalsResponse {
  const factory ProviderProposalsResponse({
    List<Projects>? projects,
    int? current_page,
    int? total,
    bool ? have_project,
    List<String>? slides,
  }) = _ProviderProposalsResponse;
  factory ProviderProposalsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProviderProposalsResponseFromJson(json);
}

@freezed
class Projects with _$Projects {
  const factory Projects({
    int? id,
    double? distance_from_me,
    String? status,
    bool? have_a_proposal,
    String? name,
    String? description,
    double? location_lat,
    double? location_lang,
    @Default(0) double equipment_cost,
    String? created_at,
    String? available_time,
    Customer? customer,
    List<Attachment>? attachment_audios,
    List<Attachment>? attachments,
    List<Attachment>? attachment_images,
    List<Attachment>? attachments_videos,
  }) = _Projects;

  factory Projects.fromJson(Map<String, dynamic> json) =>
      _$ProjectsFromJson(json);
}

@freezed
class Customer with _$Customer {
  const factory Customer({
    int? id,
    String? name,
    String? email,
    String? phone,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}

@freezed
class Attachment with _$Attachment {
  const factory Attachment({
    int? id,
    String? url,
    String? type,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}
