import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/service_form_response.dart';

part 'service_form_state.freezed.dart';

@freezed
class ServiceFormState with _$ServiceFormState {
  const factory ServiceFormState({
    @Default(ServiceFormResponse(districts: [],)) ServiceFormResponse serviceFormResponse,
    @Default(null) String? errorMessage,
    @Default(false) bool loading,
  }) = _ServiceFormState;
}
