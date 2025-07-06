// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rental_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RentalState {

 List<RentalModel> get activeRentals; bool get isLoading; String? get error;
/// Create a copy of RentalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentalStateCopyWith<RentalState> get copyWith => _$RentalStateCopyWithImpl<RentalState>(this as RentalState, _$identity);

  /// Serializes this RentalState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentalState&&const DeepCollectionEquality().equals(other.activeRentals, activeRentals)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(activeRentals),isLoading,error);

@override
String toString() {
  return 'RentalState(activeRentals: $activeRentals, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $RentalStateCopyWith<$Res>  {
  factory $RentalStateCopyWith(RentalState value, $Res Function(RentalState) _then) = _$RentalStateCopyWithImpl;
@useResult
$Res call({
 List<RentalModel> activeRentals, bool isLoading, String? error
});




}
/// @nodoc
class _$RentalStateCopyWithImpl<$Res>
    implements $RentalStateCopyWith<$Res> {
  _$RentalStateCopyWithImpl(this._self, this._then);

  final RentalState _self;
  final $Res Function(RentalState) _then;

/// Create a copy of RentalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeRentals = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
activeRentals: null == activeRentals ? _self.activeRentals : activeRentals // ignore: cast_nullable_to_non_nullable
as List<RentalModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RentalState].
extension RentalStatePatterns on RentalState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentalState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentalState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentalState value)  $default,){
final _that = this;
switch (_that) {
case _RentalState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentalState value)?  $default,){
final _that = this;
switch (_that) {
case _RentalState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RentalModel> activeRentals,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentalState() when $default != null:
return $default(_that.activeRentals,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RentalModel> activeRentals,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _RentalState():
return $default(_that.activeRentals,_that.isLoading,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RentalModel> activeRentals,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _RentalState() when $default != null:
return $default(_that.activeRentals,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RentalState implements RentalState {
  const _RentalState({required final  List<RentalModel> activeRentals, this.isLoading = false, this.error}): _activeRentals = activeRentals;
  factory _RentalState.fromJson(Map<String, dynamic> json) => _$RentalStateFromJson(json);

 final  List<RentalModel> _activeRentals;
@override List<RentalModel> get activeRentals {
  if (_activeRentals is EqualUnmodifiableListView) return _activeRentals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeRentals);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of RentalState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentalStateCopyWith<_RentalState> get copyWith => __$RentalStateCopyWithImpl<_RentalState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RentalStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentalState&&const DeepCollectionEquality().equals(other._activeRentals, _activeRentals)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_activeRentals),isLoading,error);

@override
String toString() {
  return 'RentalState(activeRentals: $activeRentals, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$RentalStateCopyWith<$Res> implements $RentalStateCopyWith<$Res> {
  factory _$RentalStateCopyWith(_RentalState value, $Res Function(_RentalState) _then) = __$RentalStateCopyWithImpl;
@override @useResult
$Res call({
 List<RentalModel> activeRentals, bool isLoading, String? error
});




}
/// @nodoc
class __$RentalStateCopyWithImpl<$Res>
    implements _$RentalStateCopyWith<$Res> {
  __$RentalStateCopyWithImpl(this._self, this._then);

  final _RentalState _self;
  final $Res Function(_RentalState) _then;

/// Create a copy of RentalState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeRentals = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_RentalState(
activeRentals: null == activeRentals ? _self._activeRentals : activeRentals // ignore: cast_nullable_to_non_nullable
as List<RentalModel>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
