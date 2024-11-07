import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import '../../../home/data/models/home_response.dart';

part 'notification_response.freezed.dart';
part 'notification_response.g.dart';

NotificationsResponse notificationResponseFromJson(String str) =>
    NotificationsResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationsResponse data) => json.encode(data.toJson());

@freezed
class NotificationsResponse with _$NotificationsResponse {
  const factory NotificationsResponse({
    @JsonKey(name: "proposals") List<Proposals>? proposals,
  }) = _NotificationsResponse;
  factory NotificationsResponse.fromJson(Map<String, dynamic> json) => _$NotificationsResponseFromJson(json);
}

@freezed
class Proposals with _$Proposals {
  const factory Proposals({
    int? id,
    double? price,
    double? original_price,
    String? description,
    Projects? project,
    Customers? customer,
    String? status,
    String? created_at,
  }) = _Proposals;

  factory Proposals.fromJson(Map<String, dynamic> json) => _$ProposalsFromJson(json);
}

@freezed
class Customers with _$Customers {
  const factory Customers({
    String? phone,
    String? name,
    String? firebase_token,
    int? id,

  }) = _Customers;

  factory Customers.fromJson(Map<String, dynamic> json) => _$CustomersFromJson(json);
}

@freezed
class Project with _$Project {
  const factory Project({
    int? id,
    String? name,
    String? description,
    double? location_lat,
    double? location_lang,
    String? status,
    bool? selected_me,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}