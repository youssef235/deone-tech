// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NotificationsState {
  NotificationsResponse get notificationsResponse =>
      throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get addLoading => throw _privateConstructorUsedError;
  String get add => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificationsStateCopyWith<NotificationsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsStateCopyWith<$Res> {
  factory $NotificationsStateCopyWith(
          NotificationsState value, $Res Function(NotificationsState) then) =
      _$NotificationsStateCopyWithImpl<$Res, NotificationsState>;
  @useResult
  $Res call(
      {NotificationsResponse notificationsResponse,
      bool loading,
      String? errorMessage,
      bool addLoading,
      String add});

  $NotificationsResponseCopyWith<$Res> get notificationsResponse;
}

/// @nodoc
class _$NotificationsStateCopyWithImpl<$Res, $Val extends NotificationsState>
    implements $NotificationsStateCopyWith<$Res> {
  _$NotificationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationsResponse = null,
    Object? loading = null,
    Object? errorMessage = freezed,
    Object? addLoading = null,
    Object? add = null,
  }) {
    return _then(_value.copyWith(
      notificationsResponse: null == notificationsResponse
          ? _value.notificationsResponse
          : notificationsResponse // ignore: cast_nullable_to_non_nullable
              as NotificationsResponse,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      addLoading: null == addLoading
          ? _value.addLoading
          : addLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      add: null == add
          ? _value.add
          : add // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationsResponseCopyWith<$Res> get notificationsResponse {
    return $NotificationsResponseCopyWith<$Res>(_value.notificationsResponse,
        (value) {
      return _then(_value.copyWith(notificationsResponse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationsStateImplCopyWith<$Res>
    implements $NotificationsStateCopyWith<$Res> {
  factory _$$NotificationsStateImplCopyWith(_$NotificationsStateImpl value,
          $Res Function(_$NotificationsStateImpl) then) =
      __$$NotificationsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NotificationsResponse notificationsResponse,
      bool loading,
      String? errorMessage,
      bool addLoading,
      String add});

  @override
  $NotificationsResponseCopyWith<$Res> get notificationsResponse;
}

/// @nodoc
class __$$NotificationsStateImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsStateImpl>
    implements _$$NotificationsStateImplCopyWith<$Res> {
  __$$NotificationsStateImplCopyWithImpl(_$NotificationsStateImpl _value,
      $Res Function(_$NotificationsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationsResponse = null,
    Object? loading = null,
    Object? errorMessage = freezed,
    Object? addLoading = null,
    Object? add = null,
  }) {
    return _then(_$NotificationsStateImpl(
      notificationsResponse: null == notificationsResponse
          ? _value.notificationsResponse
          : notificationsResponse // ignore: cast_nullable_to_non_nullable
              as NotificationsResponse,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      addLoading: null == addLoading
          ? _value.addLoading
          : addLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      add: null == add
          ? _value.add
          : add // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NotificationsStateImpl implements _NotificationsState {
  const _$NotificationsStateImpl(
      {this.notificationsResponse = const NotificationsResponse(proposals: []),
      this.loading = false,
      this.errorMessage = null,
      this.addLoading = false,
      this.add = ""});

  @override
  @JsonKey()
  final NotificationsResponse notificationsResponse;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final String? errorMessage;
  @override
  @JsonKey()
  final bool addLoading;
  @override
  @JsonKey()
  final String add;

  @override
  String toString() {
    return 'NotificationsState(notificationsResponse: $notificationsResponse, loading: $loading, errorMessage: $errorMessage, addLoading: $addLoading, add: $add)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsStateImpl &&
            (identical(other.notificationsResponse, notificationsResponse) ||
                other.notificationsResponse == notificationsResponse) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.addLoading, addLoading) ||
                other.addLoading == addLoading) &&
            (identical(other.add, add) || other.add == add));
  }

  @override
  int get hashCode => Object.hash(runtimeType, notificationsResponse, loading,
      errorMessage, addLoading, add);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsStateImplCopyWith<_$NotificationsStateImpl> get copyWith =>
      __$$NotificationsStateImplCopyWithImpl<_$NotificationsStateImpl>(
          this, _$identity);
}

abstract class _NotificationsState implements NotificationsState {
  const factory _NotificationsState(
      {final NotificationsResponse notificationsResponse,
      final bool loading,
      final String? errorMessage,
      final bool addLoading,
      final String add}) = _$NotificationsStateImpl;

  @override
  NotificationsResponse get notificationsResponse;
  @override
  bool get loading;
  @override
  String? get errorMessage;
  @override
  bool get addLoading;
  @override
  String get add;
  @override
  @JsonKey(ignore: true)
  _$$NotificationsStateImplCopyWith<_$NotificationsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
