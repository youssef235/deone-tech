// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InvoiceState {
  Invoice? get invoiceResponse => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get addLoading => throw _privateConstructorUsedError;
  String get add => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InvoiceStateCopyWith<InvoiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceStateCopyWith<$Res> {
  factory $InvoiceStateCopyWith(
          InvoiceState value, $Res Function(InvoiceState) then) =
      _$InvoiceStateCopyWithImpl<$Res, InvoiceState>;
  @useResult
  $Res call(
      {Invoice? invoiceResponse,
      bool loading,
      bool addLoading,
      String add,
      String errorMessage});
}

/// @nodoc
class _$InvoiceStateCopyWithImpl<$Res, $Val extends InvoiceState>
    implements $InvoiceStateCopyWith<$Res> {
  _$InvoiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceResponse = freezed,
    Object? loading = null,
    Object? addLoading = null,
    Object? add = null,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      invoiceResponse: freezed == invoiceResponse
          ? _value.invoiceResponse
          : invoiceResponse // ignore: cast_nullable_to_non_nullable
              as Invoice?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      addLoading: null == addLoading
          ? _value.addLoading
          : addLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      add: null == add
          ? _value.add
          : add // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvoiceStateImplCopyWith<$Res>
    implements $InvoiceStateCopyWith<$Res> {
  factory _$$InvoiceStateImplCopyWith(
          _$InvoiceStateImpl value, $Res Function(_$InvoiceStateImpl) then) =
      __$$InvoiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Invoice? invoiceResponse,
      bool loading,
      bool addLoading,
      String add,
      String errorMessage});
}

/// @nodoc
class __$$InvoiceStateImplCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res, _$InvoiceStateImpl>
    implements _$$InvoiceStateImplCopyWith<$Res> {
  __$$InvoiceStateImplCopyWithImpl(
      _$InvoiceStateImpl _value, $Res Function(_$InvoiceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceResponse = freezed,
    Object? loading = null,
    Object? addLoading = null,
    Object? add = null,
    Object? errorMessage = null,
  }) {
    return _then(_$InvoiceStateImpl(
      invoiceResponse: freezed == invoiceResponse
          ? _value.invoiceResponse
          : invoiceResponse // ignore: cast_nullable_to_non_nullable
              as Invoice?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      addLoading: null == addLoading
          ? _value.addLoading
          : addLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      add: null == add
          ? _value.add
          : add // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InvoiceStateImpl implements _InvoiceState {
  const _$InvoiceStateImpl(
      {this.invoiceResponse = null,
      this.loading = false,
      this.addLoading = false,
      this.add = "",
      this.errorMessage = ""});

  @override
  @JsonKey()
  final Invoice? invoiceResponse;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool addLoading;
  @override
  @JsonKey()
  final String add;
  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'InvoiceState(invoiceResponse: $invoiceResponse, loading: $loading, addLoading: $addLoading, add: $add, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceStateImpl &&
            (identical(other.invoiceResponse, invoiceResponse) ||
                other.invoiceResponse == invoiceResponse) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.addLoading, addLoading) ||
                other.addLoading == addLoading) &&
            (identical(other.add, add) || other.add == add) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, invoiceResponse, loading, addLoading, add, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceStateImplCopyWith<_$InvoiceStateImpl> get copyWith =>
      __$$InvoiceStateImplCopyWithImpl<_$InvoiceStateImpl>(this, _$identity);
}

abstract class _InvoiceState implements InvoiceState {
  const factory _InvoiceState(
      {final Invoice? invoiceResponse,
      final bool loading,
      final bool addLoading,
      final String add,
      final String errorMessage}) = _$InvoiceStateImpl;

  @override
  Invoice? get invoiceResponse;
  @override
  bool get loading;
  @override
  bool get addLoading;
  @override
  String get add;
  @override
  String get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$InvoiceStateImplCopyWith<_$InvoiceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
