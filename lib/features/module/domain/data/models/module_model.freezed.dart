// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'module_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ModuleModel {

 String get id; String get name; String get description; String get location; double get latitude; double get longitude; List<LockerModel> get lockers; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ModuleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModuleModelCopyWith<ModuleModel> get copyWith => _$ModuleModelCopyWithImpl<ModuleModel>(this as ModuleModel, _$identity);

  /// Serializes this ModuleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModuleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other.lockers, lockers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,location,latitude,longitude,const DeepCollectionEquality().hash(lockers),createdAt,updatedAt);

@override
String toString() {
  return 'ModuleModel(id: $id, name: $name, description: $description, location: $location, latitude: $latitude, longitude: $longitude, lockers: $lockers, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ModuleModelCopyWith<$Res>  {
  factory $ModuleModelCopyWith(ModuleModel value, $Res Function(ModuleModel) _then) = _$ModuleModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String location, double latitude, double longitude, List<LockerModel> lockers, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ModuleModelCopyWithImpl<$Res>
    implements $ModuleModelCopyWith<$Res> {
  _$ModuleModelCopyWithImpl(this._self, this._then);

  final ModuleModel _self;
  final $Res Function(ModuleModel) _then;

/// Create a copy of ModuleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? location = null,Object? latitude = null,Object? longitude = null,Object? lockers = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,lockers: null == lockers ? _self.lockers : lockers // ignore: cast_nullable_to_non_nullable
as List<LockerModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ModuleModel].
extension ModuleModelPatterns on ModuleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModuleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModuleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModuleModel value)  $default,){
final _that = this;
switch (_that) {
case _ModuleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModuleModel value)?  $default,){
final _that = this;
switch (_that) {
case _ModuleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String location,  double latitude,  double longitude,  List<LockerModel> lockers,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModuleModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.location,_that.latitude,_that.longitude,_that.lockers,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String location,  double latitude,  double longitude,  List<LockerModel> lockers,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ModuleModel():
return $default(_that.id,_that.name,_that.description,_that.location,_that.latitude,_that.longitude,_that.lockers,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String location,  double latitude,  double longitude,  List<LockerModel> lockers,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ModuleModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.location,_that.latitude,_that.longitude,_that.lockers,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModuleModel implements ModuleModel {
  const _ModuleModel({required this.id, required this.name, required this.description, required this.location, required this.latitude, required this.longitude, final  List<LockerModel> lockers = const [], required this.createdAt, required this.updatedAt}): _lockers = lockers;
  factory _ModuleModel.fromJson(Map<String, dynamic> json) => _$ModuleModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String location;
@override final  double latitude;
@override final  double longitude;
 final  List<LockerModel> _lockers;
@override@JsonKey() List<LockerModel> get lockers {
  if (_lockers is EqualUnmodifiableListView) return _lockers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lockers);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ModuleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModuleModelCopyWith<_ModuleModel> get copyWith => __$ModuleModelCopyWithImpl<_ModuleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModuleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModuleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other._lockers, _lockers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,location,latitude,longitude,const DeepCollectionEquality().hash(_lockers),createdAt,updatedAt);

@override
String toString() {
  return 'ModuleModel(id: $id, name: $name, description: $description, location: $location, latitude: $latitude, longitude: $longitude, lockers: $lockers, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ModuleModelCopyWith<$Res> implements $ModuleModelCopyWith<$Res> {
  factory _$ModuleModelCopyWith(_ModuleModel value, $Res Function(_ModuleModel) _then) = __$ModuleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String location, double latitude, double longitude, List<LockerModel> lockers, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ModuleModelCopyWithImpl<$Res>
    implements _$ModuleModelCopyWith<$Res> {
  __$ModuleModelCopyWithImpl(this._self, this._then);

  final _ModuleModel _self;
  final $Res Function(_ModuleModel) _then;

/// Create a copy of ModuleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? location = null,Object? latitude = null,Object? longitude = null,Object? lockers = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ModuleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,lockers: null == lockers ? _self._lockers : lockers // ignore: cast_nullable_to_non_nullable
as List<LockerModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
