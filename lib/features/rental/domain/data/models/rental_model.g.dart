// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RentalModel _$RentalModelFromJson(Map<String, dynamic> json) => _RentalModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  lockerId: json['lockerId'] as String,
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$RentalModelToJson(_RentalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'lockerId': instance.lockerId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
