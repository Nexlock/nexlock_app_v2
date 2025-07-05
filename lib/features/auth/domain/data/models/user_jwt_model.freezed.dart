// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_jwt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserJwtModel {

 String get id; String get email; String get name;
/// Create a copy of UserJwtModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserJwtModelCopyWith<UserJwtModel> get copyWith => _$UserJwtModelCopyWithImpl<UserJwtModel>(this as UserJwtModel, _$identity);

  /// Serializes this UserJwtModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserJwtModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,name);

@override
String toString() {
  return 'UserJwtModel(id: $id, email: $email, name: $name)';
}


}

/// @nodoc
abstract mixin class $UserJwtModelCopyWith<$Res>  {
  factory $UserJwtModelCopyWith(UserJwtModel value, $Res Function(UserJwtModel) _then) = _$UserJwtModelCopyWithImpl;
@useResult
$Res call({
 String id, String email, String name
});




}
/// @nodoc
class _$UserJwtModelCopyWithImpl<$Res>
    implements $UserJwtModelCopyWith<$Res> {
  _$UserJwtModelCopyWithImpl(this._self, this._then);

  final UserJwtModel _self;
  final $Res Function(UserJwtModel) _then;

/// Create a copy of UserJwtModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserJwtModel].
extension UserJwtModelPatterns on UserJwtModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserJwtModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserJwtModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserJwtModel value)  $default,){
final _that = this;
switch (_that) {
case _UserJwtModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserJwtModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserJwtModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserJwtModel() when $default != null:
return $default(_that.id,_that.email,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String name)  $default,) {final _that = this;
switch (_that) {
case _UserJwtModel():
return $default(_that.id,_that.email,_that.name);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String name)?  $default,) {final _that = this;
switch (_that) {
case _UserJwtModel() when $default != null:
return $default(_that.id,_that.email,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserJwtModel implements UserJwtModel {
  const _UserJwtModel({required this.id, required this.email, required this.name});
  factory _UserJwtModel.fromJson(Map<String, dynamic> json) => _$UserJwtModelFromJson(json);

@override final  String id;
@override final  String email;
@override final  String name;

/// Create a copy of UserJwtModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserJwtModelCopyWith<_UserJwtModel> get copyWith => __$UserJwtModelCopyWithImpl<_UserJwtModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserJwtModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserJwtModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,name);

@override
String toString() {
  return 'UserJwtModel(id: $id, email: $email, name: $name)';
}


}

/// @nodoc
abstract mixin class _$UserJwtModelCopyWith<$Res> implements $UserJwtModelCopyWith<$Res> {
  factory _$UserJwtModelCopyWith(_UserJwtModel value, $Res Function(_UserJwtModel) _then) = __$UserJwtModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String name
});




}
/// @nodoc
class __$UserJwtModelCopyWithImpl<$Res>
    implements _$UserJwtModelCopyWith<$Res> {
  __$UserJwtModelCopyWithImpl(this._self, this._then);

  final _UserJwtModel _self;
  final $Res Function(_UserJwtModel) _then;

/// Create a copy of UserJwtModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? name = null,}) {
  return _then(_UserJwtModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
