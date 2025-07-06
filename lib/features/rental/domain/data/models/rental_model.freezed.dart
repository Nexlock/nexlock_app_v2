// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rental_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RentalModel {

 String get id; String get userId; String get lockerId; DateTime get startTime; DateTime? get endTime; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of RentalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentalModelCopyWith<RentalModel> get copyWith => _$RentalModelCopyWithImpl<RentalModel>(this as RentalModel, _$identity);

  /// Serializes this RentalModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentalModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.lockerId, lockerId) || other.lockerId == lockerId)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,lockerId,startTime,endTime,createdAt,updatedAt);

@override
String toString() {
  return 'RentalModel(id: $id, userId: $userId, lockerId: $lockerId, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RentalModelCopyWith<$Res>  {
  factory $RentalModelCopyWith(RentalModel value, $Res Function(RentalModel) _then) = _$RentalModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String lockerId, DateTime startTime, DateTime? endTime, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$RentalModelCopyWithImpl<$Res>
    implements $RentalModelCopyWith<$Res> {
  _$RentalModelCopyWithImpl(this._self, this._then);

  final RentalModel _self;
  final $Res Function(RentalModel) _then;

/// Create a copy of RentalModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? lockerId = null,Object? startTime = null,Object? endTime = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,lockerId: null == lockerId ? _self.lockerId : lockerId // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RentalModel].
extension RentalModelPatterns on RentalModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentalModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentalModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentalModel value)  $default,){
final _that = this;
switch (_that) {
case _RentalModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentalModel value)?  $default,){
final _that = this;
switch (_that) {
case _RentalModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String lockerId,  DateTime startTime,  DateTime? endTime,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentalModel() when $default != null:
return $default(_that.id,_that.userId,_that.lockerId,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String lockerId,  DateTime startTime,  DateTime? endTime,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RentalModel():
return $default(_that.id,_that.userId,_that.lockerId,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String lockerId,  DateTime startTime,  DateTime? endTime,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RentalModel() when $default != null:
return $default(_that.id,_that.userId,_that.lockerId,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RentalModel implements RentalModel {
  const _RentalModel({required this.id, required this.userId, required this.lockerId, required this.startTime, this.endTime, required this.createdAt, required this.updatedAt});
  factory _RentalModel.fromJson(Map<String, dynamic> json) => _$RentalModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String lockerId;
@override final  DateTime startTime;
@override final  DateTime? endTime;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of RentalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentalModelCopyWith<_RentalModel> get copyWith => __$RentalModelCopyWithImpl<_RentalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RentalModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentalModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.lockerId, lockerId) || other.lockerId == lockerId)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,lockerId,startTime,endTime,createdAt,updatedAt);

@override
String toString() {
  return 'RentalModel(id: $id, userId: $userId, lockerId: $lockerId, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RentalModelCopyWith<$Res> implements $RentalModelCopyWith<$Res> {
  factory _$RentalModelCopyWith(_RentalModel value, $Res Function(_RentalModel) _then) = __$RentalModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String lockerId, DateTime startTime, DateTime? endTime, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$RentalModelCopyWithImpl<$Res>
    implements _$RentalModelCopyWith<$Res> {
  __$RentalModelCopyWithImpl(this._self, this._then);

  final _RentalModel _self;
  final $Res Function(_RentalModel) _then;

/// Create a copy of RentalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? lockerId = null,Object? startTime = null,Object? endTime = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_RentalModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,lockerId: null == lockerId ? _self.lockerId : lockerId // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
