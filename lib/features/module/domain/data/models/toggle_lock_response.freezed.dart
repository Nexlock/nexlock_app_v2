// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toggle_lock_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ToggleLockResponse {

 bool get success; String get message; String get lockerId; bool get requestedState;
/// Create a copy of ToggleLockResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleLockResponseCopyWith<ToggleLockResponse> get copyWith => _$ToggleLockResponseCopyWithImpl<ToggleLockResponse>(this as ToggleLockResponse, _$identity);

  /// Serializes this ToggleLockResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleLockResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.lockerId, lockerId) || other.lockerId == lockerId)&&(identical(other.requestedState, requestedState) || other.requestedState == requestedState));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,lockerId,requestedState);

@override
String toString() {
  return 'ToggleLockResponse(success: $success, message: $message, lockerId: $lockerId, requestedState: $requestedState)';
}


}

/// @nodoc
abstract mixin class $ToggleLockResponseCopyWith<$Res>  {
  factory $ToggleLockResponseCopyWith(ToggleLockResponse value, $Res Function(ToggleLockResponse) _then) = _$ToggleLockResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, String lockerId, bool requestedState
});




}
/// @nodoc
class _$ToggleLockResponseCopyWithImpl<$Res>
    implements $ToggleLockResponseCopyWith<$Res> {
  _$ToggleLockResponseCopyWithImpl(this._self, this._then);

  final ToggleLockResponse _self;
  final $Res Function(ToggleLockResponse) _then;

/// Create a copy of ToggleLockResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? lockerId = null,Object? requestedState = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,lockerId: null == lockerId ? _self.lockerId : lockerId // ignore: cast_nullable_to_non_nullable
as String,requestedState: null == requestedState ? _self.requestedState : requestedState // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ToggleLockResponse].
extension ToggleLockResponsePatterns on ToggleLockResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToggleLockResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToggleLockResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToggleLockResponse value)  $default,){
final _that = this;
switch (_that) {
case _ToggleLockResponse():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToggleLockResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ToggleLockResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  String lockerId,  bool requestedState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToggleLockResponse() when $default != null:
return $default(_that.success,_that.message,_that.lockerId,_that.requestedState);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  String lockerId,  bool requestedState)  $default,) {final _that = this;
switch (_that) {
case _ToggleLockResponse():
return $default(_that.success,_that.message,_that.lockerId,_that.requestedState);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  String lockerId,  bool requestedState)?  $default,) {final _that = this;
switch (_that) {
case _ToggleLockResponse() when $default != null:
return $default(_that.success,_that.message,_that.lockerId,_that.requestedState);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ToggleLockResponse implements ToggleLockResponse {
  const _ToggleLockResponse({required this.success, required this.message, required this.lockerId, required this.requestedState});
  factory _ToggleLockResponse.fromJson(Map<String, dynamic> json) => _$ToggleLockResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  String lockerId;
@override final  bool requestedState;

/// Create a copy of ToggleLockResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleLockResponseCopyWith<_ToggleLockResponse> get copyWith => __$ToggleLockResponseCopyWithImpl<_ToggleLockResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ToggleLockResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleLockResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.lockerId, lockerId) || other.lockerId == lockerId)&&(identical(other.requestedState, requestedState) || other.requestedState == requestedState));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,lockerId,requestedState);

@override
String toString() {
  return 'ToggleLockResponse(success: $success, message: $message, lockerId: $lockerId, requestedState: $requestedState)';
}


}

/// @nodoc
abstract mixin class _$ToggleLockResponseCopyWith<$Res> implements $ToggleLockResponseCopyWith<$Res> {
  factory _$ToggleLockResponseCopyWith(_ToggleLockResponse value, $Res Function(_ToggleLockResponse) _then) = __$ToggleLockResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, String lockerId, bool requestedState
});




}
/// @nodoc
class __$ToggleLockResponseCopyWithImpl<$Res>
    implements _$ToggleLockResponseCopyWith<$Res> {
  __$ToggleLockResponseCopyWithImpl(this._self, this._then);

  final _ToggleLockResponse _self;
  final $Res Function(_ToggleLockResponse) _then;

/// Create a copy of ToggleLockResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? lockerId = null,Object? requestedState = null,}) {
  return _then(_ToggleLockResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,lockerId: null == lockerId ? _self.lockerId : lockerId // ignore: cast_nullable_to_non_nullable
as String,requestedState: null == requestedState ? _self.requestedState : requestedState // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
