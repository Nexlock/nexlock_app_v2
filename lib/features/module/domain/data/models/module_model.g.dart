// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ModuleModel _$ModuleModelFromJson(Map<String, dynamic> json) => _ModuleModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  location: json['location'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  lockers:
      (json['lockers'] as List<dynamic>?)
          ?.map((e) => LockerModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ModuleModelToJson(_ModuleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'lockers': instance.lockers,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
