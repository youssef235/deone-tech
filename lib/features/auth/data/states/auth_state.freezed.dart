// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  User? get user => throw _privateConstructorUsedError;
  ServicesResponse get servicesResponse => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  bool? get isLogin => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get moreLoading => throw _privateConstructorUsedError;
  bool get registerLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call(
      {User? user,
      ServicesResponse servicesResponse,
      String? token,
      bool? isLogin,
      bool loading,
      String? errorMessage,
      bool moreLoading,
      bool registerLoading});

  $UserCopyWith<$Res>? get user;
  $ServicesResponseCopyWith<$Res> get servicesResponse;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? servicesResponse = null,
    Object? token = freezed,
    Object? isLogin = freezed,
    Object? loading = null,
    Object? errorMessage = freezed,
    Object? moreLoading = null,
    Object? registerLoading = null,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      servicesResponse: null == servicesResponse
          ? _value.servicesResponse
          : servicesResponse // ignore: cast_nullable_to_non_nullable
              as ServicesResponse,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      isLogin: freezed == isLogin
          ? _value.isLogin
          : isLogin // ignore: cast_nullable_to_non_nullable
              as bool?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      moreLoading: null == moreLoading
          ? _value.moreLoading
          : moreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      registerLoading: null == registerLoading
          ? _value.registerLoading
          : registerLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ServicesResponseCopyWith<$Res> get servicesResponse {
    return $ServicesResponseCopyWith<$Res>(_value.servicesResponse, (value) {
      return _then(_value.copyWith(servicesResponse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
          _$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {User? user,
      ServicesResponse servicesResponse,
      String? token,
      bool? isLogin,
      bool loading,
      String? errorMessage,
      bool moreLoading,
      bool registerLoading});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $ServicesResponseCopyWith<$Res> get servicesResponse;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
      _$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? servicesResponse = null,
    Object? token = freezed,
    Object? isLogin = freezed,
    Object? loading = null,
    Object? errorMessage = freezed,
    Object? moreLoading = null,
    Object? registerLoading = null,
  }) {
    return _then(_$AuthStateImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      servicesResponse: null == servicesResponse
          ? _value.servicesResponse
          : servicesResponse // ignore: cast_nullable_to_non_nullable
              as ServicesResponse,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      isLogin: freezed == isLogin
          ? _value.isLogin
          : isLogin // ignore: cast_nullable_to_non_nullable
              as bool?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      moreLoading: null == moreLoading
          ? _value.moreLoading
          : moreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      registerLoading: null == registerLoading
          ? _value.registerLoading
          : registerLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl(
      {this.user = null,
      this.servicesResponse = const ServicesResponse(services: []),
      this.token = "",
      this.isLogin = false,
      this.loading = false,
      this.errorMessage = null,
      this.moreLoading = false,
      this.registerLoading = false});

  @override
  @JsonKey()
  final User? user;
  @override
  @JsonKey()
  final ServicesResponse servicesResponse;
  @override
  @JsonKey()
  final String? token;
  @override
  @JsonKey()
  final bool? isLogin;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final String? errorMessage;
  @override
  @JsonKey()
  final bool moreLoading;
  @override
  @JsonKey()
  final bool registerLoading;

  @override
  String toString() {
    return 'AuthState(user: $user, servicesResponse: $servicesResponse, token: $token, isLogin: $isLogin, loading: $loading, errorMessage: $errorMessage, moreLoading: $moreLoading, registerLoading: $registerLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.servicesResponse, servicesResponse) ||
                other.servicesResponse == servicesResponse) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.isLogin, isLogin) || other.isLogin == isLogin) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.moreLoading, moreLoading) ||
                other.moreLoading == moreLoading) &&
            (identical(other.registerLoading, registerLoading) ||
                other.registerLoading == registerLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, servicesResponse, token,
      isLogin, loading, errorMessage, moreLoading, registerLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {final User? user,
      final ServicesResponse servicesResponse,
      final String? token,
      final bool? isLogin,
      final bool loading,
      final String? errorMessage,
      final bool moreLoading,
      final bool registerLoading}) = _$AuthStateImpl;

  @override
  User? get user;
  @override
  ServicesResponse get servicesResponse;
  @override
  String? get token;
  @override
  bool? get isLogin;
  @override
  bool get loading;
  @override
  String? get errorMessage;
  @override
  bool get moreLoading;
  @override
  bool get registerLoading;
  @override
  @JsonKey(ignore: true)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
