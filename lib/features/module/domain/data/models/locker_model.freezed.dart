// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locker_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LockerModel {

 String get id; String get moduleId; bool get isOpen; List<RentalModel> get lockerRental; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of LockerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LockerModelCopyWith<LockerModel> get copyWith => _$LockerModelCopyWithImpl<LockerModel>(this as LockerModel, _$identity);

  /// Serializes this LockerModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LockerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other.lockerRental, lockerRental)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,moduleId,isOpen,const DeepCollectionEquality().hash(lockerRental),createdAt,updatedAt);

@override
String toString() {
  return 'LockerModel(id: $id, moduleId: $moduleId, isOpen: $isOpen, lockerRental: $lockerRental, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LockerModelCopyWith<$Res>  {
  factory $LockerModelCopyWith(LockerModel value, $Res Function(LockerModel) _then) = _$LockerModelCopyWithImpl;
@useResult
$Res call({
 String id, String moduleId, bool isOpen, List<RentalModel> lockerRental, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$LockerModelCopyWithImpl<$Res>
    implements $LockerModelCopyWith<$Res> {
  _$LockerModelCopyWithImpl(this._self, this._then);

  final LockerModel _self;
  final $Res Function(LockerModel) _then;

/// Create a copy of LockerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? moduleId = null,Object? isOpen = null,Object? lockerRental = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,lockerRental: null == lockerRental ? _self.lockerRental : lockerRental // ignore: cast_nullable_to_non_nullable
as List<RentalModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LockerModel].
extension LockerModelPatterns on LockerModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LockerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LockerModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LockerModel value)  $default,){
final _that = this;
switch (_that) {
case _LockerModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LockerModel value)?  $default,){
final _that = this;
switch (_that) {
case _LockerModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String moduleId,  bool isOpen,  List<RentalModel> lockerRental,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LockerModel() when $default != null:
return $default(_that.id,_that.moduleId,_that.isOpen,_that.lockerRental,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String moduleId,  bool isOpen,  List<RentalModel> lockerRental,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _LockerModel():
return $default(_that.id,_that.moduleId,_that.isOpen,_that.lockerRental,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String moduleId,  bool isOpen,  List<RentalModel> lockerRental,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _LockerModel() when $default != null:
return $default(_that.id,_that.moduleId,_that.isOpen,_that.lockerRental,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LockerModel implements LockerModel {
  const _LockerModel({required this.id, required this.moduleId, required this.isOpen, final  List<RentalModel> lockerRental = const [], required this.createdAt, required this.updatedAt}): _lockerRental = lockerRental;
  factory _LockerModel.fromJson(Map<String, dynamic> json) => _$LockerModelFromJson(json);

@override final  String id;
@override final  String moduleId;
@override final  bool isOpen;
 final  List<RentalModel> _lockerRental;
@override@JsonKey() List<RentalModel> get lockerRental {
  if (_lockerRental is EqualUnmodifiableListView) return _lockerRental;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lockerRental);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of LockerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LockerModelCopyWith<_LockerModel> get copyWith => __$LockerModelCopyWithImpl<_LockerModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LockerModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LockerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other._lockerRental, _lockerRental)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,moduleId,isOpen,const DeepCollectionEquality().hash(_lockerRental),createdAt,updatedAt);

@override
String toString() {
  return 'LockerModel(id: $id, moduleId: $moduleId, isOpen: $isOpen, lockerRental: $lockerRental, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$LockerModelCopyWith<$Res> implements $LockerModelCopyWith<$Res> {
  factory _$LockerModelCopyWith(_LockerModel value, $Res Function(_LockerModel) _then) = __$LockerModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String moduleId, bool isOpen, List<RentalModel> lockerRental, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$LockerModelCopyWithImpl<$Res>
    implements _$LockerModelCopyWith<$Res> {
  __$LockerModelCopyWithImpl(this._self, this._then);

  final _LockerModel _self;
  final $Res Function(_LockerModel) _then;

/// Create a copy of LockerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? moduleId = null,Object? isOpen = null,Object? lockerRental = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_LockerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,lockerRental: null == lockerRental ? _self._lockerRental : lockerRental // ignore: cast_nullable_to_non_nullable
as List<RentalModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
