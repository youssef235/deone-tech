// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProviderProposalsResponse _$ProviderProposalsResponseFromJson(
    Map<String, dynamic> json) {
  return _ProviderProposalsResponse.fromJson(json);
}

/// @nodoc
mixin _$ProviderProposalsResponse {
  List<Projects>? get projects => throw _privateConstructorUsedError;
  int? get current_page => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  bool? get have_project => throw _privateConstructorUsedError;
  List<String>? get slides => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProviderProposalsResponseCopyWith<ProviderProposalsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderProposalsResponseCopyWith<$Res> {
  factory $ProviderProposalsResponseCopyWith(ProviderProposalsResponse value,
          $Res Function(ProviderProposalsResponse) then) =
      _$ProviderProposalsResponseCopyWithImpl<$Res, ProviderProposalsResponse>;
  @useResult
  $Res call(
      {List<Projects>? projects,
      int? current_page,
      int? total,
      bool? have_project,
      List<String>? slides});
}

/// @nodoc
class _$ProviderProposalsResponseCopyWithImpl<$Res,
        $Val extends ProviderProposalsResponse>
    implements $ProviderProposalsResponseCopyWith<$Res> {
  _$ProviderProposalsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = freezed,
    Object? current_page = freezed,
    Object? total = freezed,
    Object? have_project = freezed,
    Object? slides = freezed,
  }) {
    return _then(_value.copyWith(
      projects: freezed == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Projects>?,
      current_page: freezed == current_page
          ? _value.current_page
          : current_page // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      have_project: freezed == have_project
          ? _value.have_project
          : have_project // ignore: cast_nullable_to_non_nullable
              as bool?,
      slides: freezed == slides
          ? _value.slides
          : slides // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProviderProposalsResponseImplCopyWith<$Res>
    implements $ProviderProposalsResponseCopyWith<$Res> {
  factory _$$ProviderProposalsResponseImplCopyWith(
          _$ProviderProposalsResponseImpl value,
          $Res Function(_$ProviderProposalsResponseImpl) then) =
      __$$ProviderProposalsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Projects>? projects,
      int? current_page,
      int? total,
      bool? have_project,
      List<String>? slides});
}

/// @nodoc
class __$$ProviderProposalsResponseImplCopyWithImpl<$Res>
    extends _$ProviderProposalsResponseCopyWithImpl<$Res,
        _$ProviderProposalsResponseImpl>
    implements _$$ProviderProposalsResponseImplCopyWith<$Res> {
  __$$ProviderProposalsResponseImplCopyWithImpl(
      _$ProviderProposalsResponseImpl _value,
      $Res Function(_$ProviderProposalsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = freezed,
    Object? current_page = freezed,
    Object? total = freezed,
    Object? have_project = freezed,
    Object? slides = freezed,
  }) {
    return _then(_$ProviderProposalsResponseImpl(
      projects: freezed == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<Projects>?,
      current_page: freezed == current_page
          ? _value.current_page
          : current_page // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      have_project: freezed == have_project
          ? _value.have_project
          : have_project // ignore: cast_nullable_to_non_nullable
              as bool?,
      slides: freezed == slides
          ? _value._slides
          : slides // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProviderProposalsResponseImpl implements _ProviderProposalsResponse {
  const _$ProviderProposalsResponseImpl(
      {final List<Projects>? projects,
      this.current_page,
      this.total,
      this.have_project,
      final List<String>? slides})
      : _projects = projects,
        _slides = slides;

  factory _$ProviderProposalsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProviderProposalsResponseImplFromJson(json);

  final List<Projects>? _projects;
  @override
  List<Projects>? get projects {
    final value = _projects;
    if (value == null) return null;
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? current_page;
  @override
  final int? total;
  @override
  final bool? have_project;
  final List<String>? _slides;
  @override
  List<String>? get slides {
    final value = _slides;
    if (value == null) return null;
    if (_slides is EqualUnmodifiableListView) return _slides;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProviderProposalsResponse(projects: $projects, current_page: $current_page, total: $total, have_project: $have_project, slides: $slides)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProviderProposalsResponseImpl &&
            const DeepCollectionEquality().equals(other._projects, _projects) &&
            (identical(other.current_page, current_page) ||
                other.current_page == current_page) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.have_project, have_project) ||
                other.have_project == have_project) &&
            const DeepCollectionEquality().equals(other._slides, _slides));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_projects),
      current_page,
      total,
      have_project,
      const DeepCollectionEquality().hash(_slides));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProviderProposalsResponseImplCopyWith<_$ProviderProposalsResponseImpl>
      get copyWith => __$$ProviderProposalsResponseImplCopyWithImpl<
          _$ProviderProposalsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProviderProposalsResponseImplToJson(
      this,
    );
  }
}

abstract class _ProviderProposalsResponse implements ProviderProposalsResponse {
  const factory _ProviderProposalsResponse(
      {final List<Projects>? projects,
      final int? current_page,
      final int? total,
      final bool? have_project,
      final List<String>? slides}) = _$ProviderProposalsResponseImpl;

  factory _ProviderProposalsResponse.fromJson(Map<String, dynamic> json) =
      _$ProviderProposalsResponseImpl.fromJson;

  @override
  List<Projects>? get projects;
  @override
  int? get current_page;
  @override
  int? get total;
  @override
  bool? get have_project;
  @override
  List<String>? get slides;
  @override
  @JsonKey(ignore: true)
  _$$ProviderProposalsResponseImplCopyWith<_$ProviderProposalsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Projects _$ProjectsFromJson(Map<String, dynamic> json) {
  return _Projects.fromJson(json);
}

/// @nodoc
mixin _$Projects {
  int? get id => throw _privateConstructorUsedError;
  double? get distance_from_me => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  bool? get have_a_proposal => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get location_lat => throw _privateConstructorUsedError;
  double? get location_lang => throw _privateConstructorUsedError;
  double get equipment_cost => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;
  String? get available_time => throw _privateConstructorUsedError;
  Customer? get customer => throw _privateConstructorUsedError;
  List<Attachment>? get attachment_audios => throw _privateConstructorUsedError;
  List<Attachment>? get attachments => throw _privateConstructorUsedError;
  List<Attachment>? get attachment_images => throw _privateConstructorUsedError;
  List<Attachment>? get attachments_videos =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectsCopyWith<Projects> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectsCopyWith<$Res> {
  factory $ProjectsCopyWith(Projects value, $Res Function(Projects) then) =
      _$ProjectsCopyWithImpl<$Res, Projects>;
  @useResult
  $Res call(
      {int? id,
      double? distance_from_me,
      String? status,
      bool? have_a_proposal,
      String? name,
      String? description,
      double? location_lat,
      double? location_lang,
      double equipment_cost,
      String? created_at,
      String? available_time,
      Customer? customer,
      List<Attachment>? attachment_audios,
      List<Attachment>? attachments,
      List<Attachment>? attachment_images,
      List<Attachment>? attachments_videos});

  $CustomerCopyWith<$Res>? get customer;
}

/// @nodoc
class _$ProjectsCopyWithImpl<$Res, $Val extends Projects>
    implements $ProjectsCopyWith<$Res> {
  _$ProjectsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? distance_from_me = freezed,
    Object? status = freezed,
    Object? have_a_proposal = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? location_lat = freezed,
    Object? location_lang = freezed,
    Object? equipment_cost = null,
    Object? created_at = freezed,
    Object? available_time = freezed,
    Object? customer = freezed,
    Object? attachment_audios = freezed,
    Object? attachments = freezed,
    Object? attachment_images = freezed,
    Object? attachments_videos = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      distance_from_me: freezed == distance_from_me
          ? _value.distance_from_me
          : distance_from_me // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      have_a_proposal: freezed == have_a_proposal
          ? _value.have_a_proposal
          : have_a_proposal // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      equipment_cost: null == equipment_cost
          ? _value.equipment_cost
          : equipment_cost // ignore: cast_nullable_to_non_nullable
              as double,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
      available_time: freezed == available_time
          ? _value.available_time
          : available_time // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      attachment_audios: freezed == attachment_audios
          ? _value.attachment_audios
          : attachment_audios // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      attachment_images: freezed == attachment_images
          ? _value.attachment_images
          : attachment_images // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      attachments_videos: freezed == attachments_videos
          ? _value.attachments_videos
          : attachments_videos // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProjectsImplCopyWith<$Res>
    implements $ProjectsCopyWith<$Res> {
  factory _$$ProjectsImplCopyWith(
          _$ProjectsImpl value, $Res Function(_$ProjectsImpl) then) =
      __$$ProjectsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      double? distance_from_me,
      String? status,
      bool? have_a_proposal,
      String? name,
      String? description,
      double? location_lat,
      double? location_lang,
      double equipment_cost,
      String? created_at,
      String? available_time,
      Customer? customer,
      List<Attachment>? attachment_audios,
      List<Attachment>? attachments,
      List<Attachment>? attachment_images,
      List<Attachment>? attachments_videos});

  @override
  $CustomerCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$ProjectsImplCopyWithImpl<$Res>
    extends _$ProjectsCopyWithImpl<$Res, _$ProjectsImpl>
    implements _$$ProjectsImplCopyWith<$Res> {
  __$$ProjectsImplCopyWithImpl(
      _$ProjectsImpl _value, $Res Function(_$ProjectsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? distance_from_me = freezed,
    Object? status = freezed,
    Object? have_a_proposal = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? location_lat = freezed,
    Object? location_lang = freezed,
    Object? equipment_cost = null,
    Object? created_at = freezed,
    Object? available_time = freezed,
    Object? customer = freezed,
    Object? attachment_audios = freezed,
    Object? attachments = freezed,
    Object? attachment_images = freezed,
    Object? attachments_videos = freezed,
  }) {
    return _then(_$ProjectsImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      distance_from_me: freezed == distance_from_me
          ? _value.distance_from_me
          : distance_from_me // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      have_a_proposal: freezed == have_a_proposal
          ? _value.have_a_proposal
          : have_a_proposal // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      equipment_cost: null == equipment_cost
          ? _value.equipment_cost
          : equipment_cost // ignore: cast_nullable_to_non_nullable
              as double,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
      available_time: freezed == available_time
          ? _value.available_time
          : available_time // ignore: cast_nullable_to_non_nullable
              as String?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      attachment_audios: freezed == attachment_audios
          ? _value._attachment_audios
          : attachment_audios // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      attachment_images: freezed == attachment_images
          ? _value._attachment_images
          : attachment_images // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
      attachments_videos: freezed == attachments_videos
          ? _value._attachments_videos
          : attachments_videos // ignore: cast_nullable_to_non_nullable
              as List<Attachment>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectsImpl implements _Projects {
  const _$ProjectsImpl(
      {this.id,
      this.distance_from_me,
      this.status,
      this.have_a_proposal,
      this.name,
      this.description,
      this.location_lat,
      this.location_lang,
      this.equipment_cost = 0,
      this.created_at,
      this.available_time,
      this.customer,
      final List<Attachment>? attachment_audios,
      final List<Attachment>? attachments,
      final List<Attachment>? attachment_images,
      final List<Attachment>? attachments_videos})
      : _attachment_audios = attachment_audios,
        _attachments = attachments,
        _attachment_images = attachment_images,
        _attachments_videos = attachments_videos;

  factory _$ProjectsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectsImplFromJson(json);

  @override
  final int? id;
  @override
  final double? distance_from_me;
  @override
  final String? status;
  @override
  final bool? have_a_proposal;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final double? location_lat;
  @override
  final double? location_lang;
  @override
  @JsonKey()
  final double equipment_cost;
  @override
  final String? created_at;
  @override
  final String? available_time;
  @override
  final Customer? customer;
  final List<Attachment>? _attachment_audios;
  @override
  List<Attachment>? get attachment_audios {
    final value = _attachment_audios;
    if (value == null) return null;
    if (_attachment_audios is EqualUnmodifiableListView)
      return _attachment_audios;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Attachment>? _attachments;
  @override
  List<Attachment>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Attachment>? _attachment_images;
  @override
  List<Attachment>? get attachment_images {
    final value = _attachment_images;
    if (value == null) return null;
    if (_attachment_images is EqualUnmodifiableListView)
      return _attachment_images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Attachment>? _attachments_videos;
  @override
  List<Attachment>? get attachments_videos {
    final value = _attachments_videos;
    if (value == null) return null;
    if (_attachments_videos is EqualUnmodifiableListView)
      return _attachments_videos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Projects(id: $id, distance_from_me: $distance_from_me, status: $status, have_a_proposal: $have_a_proposal, name: $name, description: $description, location_lat: $location_lat, location_lang: $location_lang, equipment_cost: $equipment_cost, created_at: $created_at, available_time: $available_time, customer: $customer, attachment_audios: $attachment_audios, attachments: $attachments, attachment_images: $attachment_images, attachments_videos: $attachments_videos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.distance_from_me, distance_from_me) ||
                other.distance_from_me == distance_from_me) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.have_a_proposal, have_a_proposal) ||
                other.have_a_proposal == have_a_proposal) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location_lat, location_lat) ||
                other.location_lat == location_lat) &&
            (identical(other.location_lang, location_lang) ||
                other.location_lang == location_lang) &&
            (identical(other.equipment_cost, equipment_cost) ||
                other.equipment_cost == equipment_cost) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.available_time, available_time) ||
                other.available_time == available_time) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality()
                .equals(other._attachment_audios, _attachment_audios) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            const DeepCollectionEquality()
                .equals(other._attachment_images, _attachment_images) &&
            const DeepCollectionEquality()
                .equals(other._attachments_videos, _attachments_videos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      distance_from_me,
      status,
      have_a_proposal,
      name,
      description,
      location_lat,
      location_lang,
      equipment_cost,
      created_at,
      available_time,
      customer,
      const DeepCollectionEquality().hash(_attachment_audios),
      const DeepCollectionEquality().hash(_attachments),
      const DeepCollectionEquality().hash(_attachment_images),
      const DeepCollectionEquality().hash(_attachments_videos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectsImplCopyWith<_$ProjectsImpl> get copyWith =>
      __$$ProjectsImplCopyWithImpl<_$ProjectsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectsImplToJson(
      this,
    );
  }
}

abstract class _Projects implements Projects {
  const factory _Projects(
      {final int? id,
      final double? distance_from_me,
      final String? status,
      final bool? have_a_proposal,
      final String? name,
      final String? description,
      final double? location_lat,
      final double? location_lang,
      final double equipment_cost,
      final String? created_at,
      final String? available_time,
      final Customer? customer,
      final List<Attachment>? attachment_audios,
      final List<Attachment>? attachments,
      final List<Attachment>? attachment_images,
      final List<Attachment>? attachments_videos}) = _$ProjectsImpl;

  factory _Projects.fromJson(Map<String, dynamic> json) =
      _$ProjectsImpl.fromJson;

  @override
  int? get id;
  @override
  double? get distance_from_me;
  @override
  String? get status;
  @override
  bool? get have_a_proposal;
  @override
  String? get name;
  @override
  String? get description;
  @override
  double? get location_lat;
  @override
  double? get location_lang;
  @override
  double get equipment_cost;
  @override
  String? get created_at;
  @override
  String? get available_time;
  @override
  Customer? get customer;
  @override
  List<Attachment>? get attachment_audios;
  @override
  List<Attachment>? get attachments;
  @override
  List<Attachment>? get attachment_images;
  @override
  List<Attachment>? get attachments_videos;
  @override
  @JsonKey(ignore: true)
  _$$ProjectsImplCopyWith<_$ProjectsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res, Customer>;
  @useResult
  $Res call({int? id, String? name, String? email, String? phone});
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res, $Val extends Customer>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? phone = freezed,
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerImplCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$$CustomerImplCopyWith(
          _$CustomerImpl value, $Res Function(_$CustomerImpl) then) =
      __$$CustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? email, String? phone});
}

/// @nodoc
class __$$CustomerImplCopyWithImpl<$Res>
    extends _$CustomerCopyWithImpl<$Res, _$CustomerImpl>
    implements _$$CustomerImplCopyWith<$Res> {
  __$$CustomerImplCopyWithImpl(
      _$CustomerImpl _value, $Res Function(_$CustomerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? phone = freezed,
  }) {
    return _then(_$CustomerImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerImpl implements _Customer {
  const _$CustomerImpl({this.id, this.name, this.email, this.phone});

  factory _$CustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? phone;

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      __$$CustomerImplCopyWithImpl<_$CustomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerImplToJson(
      this,
    );
  }
}

abstract class _Customer implements Customer {
  const factory _Customer(
      {final int? id,
      final String? name,
      final String? email,
      final String? phone}) = _$CustomerImpl;

  factory _Customer.fromJson(Map<String, dynamic> json) =
      _$CustomerImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  @JsonKey(ignore: true)
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return _Attachment.fromJson(json);
}

/// @nodoc
mixin _$Attachment {
  int? get id => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttachmentCopyWith<Attachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttachmentCopyWith<$Res> {
  factory $AttachmentCopyWith(
          Attachment value, $Res Function(Attachment) then) =
      _$AttachmentCopyWithImpl<$Res, Attachment>;
  @useResult
  $Res call({int? id, String? url, String? type});
}

/// @nodoc
class _$AttachmentCopyWithImpl<$Res, $Val extends Attachment>
    implements $AttachmentCopyWith<$Res> {
  _$AttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttachmentImplCopyWith<$Res>
    implements $AttachmentCopyWith<$Res> {
  factory _$$AttachmentImplCopyWith(
          _$AttachmentImpl value, $Res Function(_$AttachmentImpl) then) =
      __$$AttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? url, String? type});
}

/// @nodoc
class __$$AttachmentImplCopyWithImpl<$Res>
    extends _$AttachmentCopyWithImpl<$Res, _$AttachmentImpl>
    implements _$$AttachmentImplCopyWith<$Res> {
  __$$AttachmentImplCopyWithImpl(
      _$AttachmentImpl _value, $Res Function(_$AttachmentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = freezed,
    Object? type = freezed,
  }) {
    return _then(_$AttachmentImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttachmentImpl implements _Attachment {
  const _$AttachmentImpl({this.id, this.url, this.type});

  factory _$AttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttachmentImplFromJson(json);

  @override
  final int? id;
  @override
  final String? url;
  @override
  final String? type;

  @override
  String toString() {
    return 'Attachment(id: $id, url: $url, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttachmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      __$$AttachmentImplCopyWithImpl<_$AttachmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttachmentImplToJson(
      this,
    );
  }
}

abstract class _Attachment implements Attachment {
  const factory _Attachment(
      {final int? id,
      final String? url,
      final String? type}) = _$AttachmentImpl;

  factory _Attachment.fromJson(Map<String, dynamic> json) =
      _$AttachmentImpl.fromJson;

  @override
  int? get id;
  @override
  String? get url;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$$AttachmentImplCopyWith<_$AttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
