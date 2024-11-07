// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user.freezed.dart';
part 'user.g.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

@freezed
class User with _$User {
  const factory User({
    String? name,
    int? id,
    double? avg_rate,
    String? phone,
    String? identity_image,
    String? personal_image,
    String? type_resident,
    String? iban_number,
    String? stcpay_number,
    String? status,
    String? active,
    double? balance,
    int? completed_projects,

  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Service with _$Service {
  const factory Service({
    int? id,
    String? name,
    String? status,
    String? created_at,
    ServiceIcon ? icon,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
}


ServicesResponse homeResponseFromJson(String str) =>
    ServicesResponse.fromJson(json.decode(str));

String servicesResponseToJson(ServicesResponse data) => json.encode(data.toJson());

@freezed
class ServicesResponse with _$ServicesResponse {
  const factory ServicesResponse({
    @JsonKey(name: "services") List<Service>? services,
  }) = _ServicesResponse;
  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseFromJson(json);
}

@freezed
class ServiceIcon with _$ServiceIcon {
  const factory ServiceIcon({
    int? id,
    String? url,
    String? type,
  }) = _ServiceIcon;

  factory ServiceIcon.fromJson(Map<String, dynamic> json) => _$ServiceIconFromJson(json);
}