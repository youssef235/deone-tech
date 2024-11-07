// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationsResponse _$NotificationsResponseFromJson(
    Map<String, dynamic> json) {
  return _NotificationsResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationsResponse {
  @JsonKey(name: "proposals")
  List<Proposals>? get proposals => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationsResponseCopyWith<NotificationsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsResponseCopyWith<$Res> {
  factory $NotificationsResponseCopyWith(NotificationsResponse value,
          $Res Function(NotificationsResponse) then) =
      _$NotificationsResponseCopyWithImpl<$Res, NotificationsResponse>;
  @useResult
  $Res call({@JsonKey(name: "proposals") List<Proposals>? proposals});
}

/// @nodoc
class _$NotificationsResponseCopyWithImpl<$Res,
        $Val extends NotificationsResponse>
    implements $NotificationsResponseCopyWith<$Res> {
  _$NotificationsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proposals = freezed,
  }) {
    return _then(_value.copyWith(
      proposals: freezed == proposals
          ? _value.proposals
          : proposals // ignore: cast_nullable_to_non_nullable
              as List<Proposals>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationsResponseImplCopyWith<$Res>
    implements $NotificationsResponseCopyWith<$Res> {
  factory _$$NotificationsResponseImplCopyWith(
          _$NotificationsResponseImpl value,
          $Res Function(_$NotificationsResponseImpl) then) =
      __$$NotificationsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "proposals") List<Proposals>? proposals});
}

/// @nodoc
class __$$NotificationsResponseImplCopyWithImpl<$Res>
    extends _$NotificationsResponseCopyWithImpl<$Res,
        _$NotificationsResponseImpl>
    implements _$$NotificationsResponseImplCopyWith<$Res> {
  __$$NotificationsResponseImplCopyWithImpl(_$NotificationsResponseImpl _value,
      $Res Function(_$NotificationsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proposals = freezed,
  }) {
    return _then(_$NotificationsResponseImpl(
      proposals: freezed == proposals
          ? _value._proposals
          : proposals // ignore: cast_nullable_to_non_nullable
              as List<Proposals>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationsResponseImpl implements _NotificationsResponse {
  const _$NotificationsResponseImpl(
      {@JsonKey(name: "proposals") final List<Proposals>? proposals})
      : _proposals = proposals;

  factory _$NotificationsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationsResponseImplFromJson(json);

  final List<Proposals>? _proposals;
  @override
  @JsonKey(name: "proposals")
  List<Proposals>? get proposals {
    final value = _proposals;
    if (value == null) return null;
    if (_proposals is EqualUnmodifiableListView) return _proposals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'NotificationsResponse(proposals: $proposals)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._proposals, _proposals));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_proposals));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsResponseImplCopyWith<_$NotificationsResponseImpl>
      get copyWith => __$$NotificationsResponseImplCopyWithImpl<
          _$NotificationsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationsResponseImplToJson(
      this,
    );
  }
}

abstract class _NotificationsResponse implements NotificationsResponse {
  const factory _NotificationsResponse(
          {@JsonKey(name: "proposals") final List<Proposals>? proposals}) =
      _$NotificationsResponseImpl;

  factory _NotificationsResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationsResponseImpl.fromJson;

  @override
  @JsonKey(name: "proposals")
  List<Proposals>? get proposals;
  @override
  @JsonKey(ignore: true)
  _$$NotificationsResponseImplCopyWith<_$NotificationsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Proposals _$ProposalsFromJson(Map<String, dynamic> json) {
  return _Proposals.fromJson(json);
}

/// @nodoc
mixin _$Proposals {
  int? get id => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  double? get original_price => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Projects? get project => throw _privateConstructorUsedError;
  Customers? get customer => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProposalsCopyWith<Proposals> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProposalsCopyWith<$Res> {
  factory $ProposalsCopyWith(Proposals value, $Res Function(Proposals) then) =
      _$ProposalsCopyWithImpl<$Res, Proposals>;
  @useResult
  $Res call(
      {int? id,
      double? price,
      double? original_price,
      String? description,
      Projects? project,
      Customers? customer,
      String? status,
      String? created_at});

  $ProjectsCopyWith<$Res>? get project;
  $CustomersCopyWith<$Res>? get customer;
}

/// @nodoc
class _$ProposalsCopyWithImpl<$Res, $Val extends Proposals>
    implements $ProposalsCopyWith<$Res> {
  _$ProposalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? price = freezed,
    Object? original_price = freezed,
    Object? description = freezed,
    Object? project = freezed,
    Object? customer = freezed,
    Object? status = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      original_price: freezed == original_price
          ? _value.original_price
          : original_price // ignore: cast_nullable_to_non_nullable
              as double?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as Projects?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customers?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProjectsCopyWith<$Res>? get project {
    if (_value.project == null) {
      return null;
    }

    return $ProjectsCopyWith<$Res>(_value.project!, (value) {
      return _then(_value.copyWith(project: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomersCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomersCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProposalsImplCopyWith<$Res>
    implements $ProposalsCopyWith<$Res> {
  factory _$$ProposalsImplCopyWith(
          _$ProposalsImpl value, $Res Function(_$ProposalsImpl) then) =
      __$$ProposalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      double? price,
      double? original_price,
      String? description,
      Projects? project,
      Customers? customer,
      String? status,
      String? created_at});

  @override
  $ProjectsCopyWith<$Res>? get project;
  @override
  $CustomersCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$ProposalsImplCopyWithImpl<$Res>
    extends _$ProposalsCopyWithImpl<$Res, _$ProposalsImpl>
    implements _$$ProposalsImplCopyWith<$Res> {
  __$$ProposalsImplCopyWithImpl(
      _$ProposalsImpl _value, $Res Function(_$ProposalsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? price = freezed,
    Object? original_price = freezed,
    Object? description = freezed,
    Object? project = freezed,
    Object? customer = freezed,
    Object? status = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_$ProposalsImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      original_price: freezed == original_price
          ? _value.original_price
          : original_price // ignore: cast_nullable_to_non_nullable
              as double?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as Projects?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customers?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProposalsImpl implements _Proposals {
  const _$ProposalsImpl(
      {this.id,
      this.price,
      this.original_price,
      this.description,
      this.project,
      this.customer,
      this.status,
      this.created_at});

  factory _$ProposalsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProposalsImplFromJson(json);

  @override
  final int? id;
  @override
  final double? price;
  @override
  final double? original_price;
  @override
  final String? description;
  @override
  final Projects? project;
  @override
  final Customers? customer;
  @override
  final String? status;
  @override
  final String? created_at;

  @override
  String toString() {
    return 'Proposals(id: $id, price: $price, original_price: $original_price, description: $description, project: $project, customer: $customer, status: $status, created_at: $created_at)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProposalsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.original_price, original_price) ||
                other.original_price == original_price) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, price, original_price,
      description, project, customer, status, created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProposalsImplCopyWith<_$ProposalsImpl> get copyWith =>
      __$$ProposalsImplCopyWithImpl<_$ProposalsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProposalsImplToJson(
      this,
    );
  }
}

abstract class _Proposals implements Proposals {
  const factory _Proposals(
      {final int? id,
      final double? price,
      final double? original_price,
      final String? description,
      final Projects? project,
      final Customers? customer,
      final String? status,
      final String? created_at}) = _$ProposalsImpl;

  factory _Proposals.fromJson(Map<String, dynamic> json) =
      _$ProposalsImpl.fromJson;

  @override
  int? get id;
  @override
  double? get price;
  @override
  double? get original_price;
  @override
  String? get description;
  @override
  Projects? get project;
  @override
  Customers? get customer;
  @override
  String? get status;
  @override
  String? get created_at;
  @override
  @JsonKey(ignore: true)
  _$$ProposalsImplCopyWith<_$ProposalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Customers _$CustomersFromJson(Map<String, dynamic> json) {
  return _Customers.fromJson(json);
}

/// @nodoc
mixin _$Customers {
  String? get phone => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get firebase_token => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomersCopyWith<Customers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomersCopyWith<$Res> {
  factory $CustomersCopyWith(Customers value, $Res Function(Customers) then) =
      _$CustomersCopyWithImpl<$Res, Customers>;
  @useResult
  $Res call({String? phone, String? name, String? firebase_token, int? id});
}

/// @nodoc
class _$CustomersCopyWithImpl<$Res, $Val extends Customers>
    implements $CustomersCopyWith<$Res> {
  _$CustomersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = freezed,
    Object? name = freezed,
    Object? firebase_token = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      firebase_token: freezed == firebase_token
          ? _value.firebase_token
          : firebase_token // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomersImplCopyWith<$Res>
    implements $CustomersCopyWith<$Res> {
  factory _$$CustomersImplCopyWith(
          _$CustomersImpl value, $Res Function(_$CustomersImpl) then) =
      __$$CustomersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? phone, String? name, String? firebase_token, int? id});
}

/// @nodoc
class __$$CustomersImplCopyWithImpl<$Res>
    extends _$CustomersCopyWithImpl<$Res, _$CustomersImpl>
    implements _$$CustomersImplCopyWith<$Res> {
  __$$CustomersImplCopyWithImpl(
      _$CustomersImpl _value, $Res Function(_$CustomersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = freezed,
    Object? name = freezed,
    Object? firebase_token = freezed,
    Object? id = freezed,
  }) {
    return _then(_$CustomersImpl(
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      firebase_token: freezed == firebase_token
          ? _value.firebase_token
          : firebase_token // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomersImpl implements _Customers {
  const _$CustomersImpl({this.phone, this.name, this.firebase_token, this.id});

  factory _$CustomersImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomersImplFromJson(json);

  @override
  final String? phone;
  @override
  final String? name;
  @override
  final String? firebase_token;
  @override
  final int? id;

  @override
  String toString() {
    return 'Customers(phone: $phone, name: $name, firebase_token: $firebase_token, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomersImpl &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.firebase_token, firebase_token) ||
                other.firebase_token == firebase_token) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, phone, name, firebase_token, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomersImplCopyWith<_$CustomersImpl> get copyWith =>
      __$$CustomersImplCopyWithImpl<_$CustomersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomersImplToJson(
      this,
    );
  }
}

abstract class _Customers implements Customers {
  const factory _Customers(
      {final String? phone,
      final String? name,
      final String? firebase_token,
      final int? id}) = _$CustomersImpl;

  factory _Customers.fromJson(Map<String, dynamic> json) =
      _$CustomersImpl.fromJson;

  @override
  String? get phone;
  @override
  String? get name;
  @override
  String? get firebase_token;
  @override
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$CustomersImplCopyWith<_$CustomersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get location_lat => throw _privateConstructorUsedError;
  double? get location_lang => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  bool? get selected_me => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? description,
      double? location_lat,
      double? location_lang,
      String? status,
      bool? selected_me});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? location_lat = freezed,
    Object? location_lang = freezed,
    Object? status = freezed,
    Object? selected_me = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      location_lat: freezed == location_lat
          ? _value.location_lat
          : location_lat // ignore: cast_nullable_to_non_nullable
              as double?,
      location_lang: freezed == location_lang
          ? _value.location_lang
          : location_lang // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      selected_me: freezed == selected_me
          ? _value.selected_me
          : selected_me // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectImplCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$ProjectImplCopyWith(
          _$ProjectImpl value, $Res Function(_$ProjectImpl) then) =
      __$$ProjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? description,
      double? location_lat,
      double? location_lang,
      String? status,
      bool? selected_me});
}

/// @nodoc
class __$$ProjectImplCopyWithImpl<$Res>
    extends _$ProjectCopyWithImpl<$Res, _$ProjectImpl>
    implements _$$ProjectImplCopyWith<$Res> {
  __$$ProjectImplCopyWithImpl(
      _$ProjectImpl _value, $Res Function(_$ProjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? location_lat = freezed,
    Object? location_lang = freezed,
    Object? status = freezed,
    Object? selected_me = freezed,
  }) {
    return _then(_$ProjectImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      location_lat: freezed == location_lat
          ? _value.location_lat
          : location_lat // ignore: cast_nullable_to_non_nullable
              as double?,
      location_lang: freezed == location_lang
          ? _value.location_lang
          : location_lang // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      selected_me: freezed == selected_me
          ? _value.selected_me
          : selected_me // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectImpl implements _Project {
  const _$ProjectImpl(
      {this.id,
      this.name,
      this.description,
      this.location_lat,
      this.location_lang,
      this.status,
      this.selected_me});

  factory _$ProjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final double? location_lat;
  @override
  final double? location_lang;
  @override
  final String? status;
  @override
  final bool? selected_me;

  @override
  String toString() {
    return 'Project(id: $id, name: $name, description: $description, location_lat: $location_lat, location_lang: $location_lang, status: $status, selected_me: $selected_me)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location_lat, location_lat) ||
                other.location_lat == location_lat) &&
            (identical(other.location_lang, location_lang) ||
                other.location_lang == location_lang) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.selected_me, selected_me) ||
                other.selected_me == selected_me));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description,
      location_lat, location_lang, status, selected_me);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      __$$ProjectImplCopyWithImpl<_$ProjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectImplToJson(
      this,
    );
  }
}

abstract class _Project implements Project {
  const factory _Project(
      {final int? id,
      final String? name,
      final String? description,
      final double? location_lat,
      final double? location_lang,
      final String? status,
      final bool? selected_me}) = _$ProjectImpl;

  factory _Project.fromJson(Map<String, dynamic> json) = _$ProjectImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  double? get location_lat;
  @override
  double? get location_lang;
  @override
  String? get status;
  @override
  bool? get selected_me;
  @override
  @JsonKey(ignore: true)
  _$$ProjectImplCopyWith<_$ProjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
