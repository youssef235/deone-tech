import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/home_response.dart';
part 'home_state.freezed.dart';
@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(ProviderProposalsResponse(current_page: 0  ,projects: [],total: 0)) ProviderProposalsResponse providerProposalsResponse,
    @Default(null) String? errorMessage,
    @Default(null) List<String>? sliders,
    @Default(true) bool slidersLoading,

    @Default(null) String? requestErrorMessage,
    @Default(true) bool loading,
    @Default(false) bool requestLoading,
    @Default("") String add,
    @Default(0) int screenIndex,
  }) = _HomeState;
}
