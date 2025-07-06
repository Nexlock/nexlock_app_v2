// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LockerModel _$LockerModelFromJson(Map<String, dynamic> json) => _LockerModel(
  id: json['id'] as String,
  moduleId: json['moduleId'] as String,
  isOpen: json['isOpen'] as bool,
  lockerRental:
      (json['lockerRental'] as List<dynamic>?)
          ?.map((e) => RentalModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$LockerModelToJson(_LockerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'moduleId': instance.moduleId,
      'isOpen': instance.isOpen,
      'lockerRental': instance.lockerRental,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
