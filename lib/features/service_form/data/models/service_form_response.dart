import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'service_form_response.freezed.dart';
part 'service_form_response.g.dart';

ServiceFormResponse serviceFormResponseFromJson(String str) =>
    ServiceFormResponse.fromJson(json.decode(str));

String serviceFormResponseToJson(ServiceFormResponse data) => json.encode(data.toJson());

@freezed
class ServiceFormResponse with _$ServiceFormResponse {
  const factory ServiceFormResponse({
    List<District>? districts,
  }) = _ServiceFormResponse;
  factory ServiceFormResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceFormResponseFromJson(json);
}

@freezed
class District with _$District {
  const factory District({
    int? id,
    String? name,
  }) = _District;

  factory District.fromJson(Map<String, dynamic> json) => _$DistrictFromJson(json);
}