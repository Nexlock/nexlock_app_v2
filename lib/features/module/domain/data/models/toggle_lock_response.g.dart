// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_lock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ToggleLockResponse _$ToggleLockResponseFromJson(Map<String, dynamic> json) =>
    _ToggleLockResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      lockerId: json['lockerId'] as String,
      requestedState: json['requestedState'] as bool,
    );

Map<String, dynamic> _$ToggleLockResponseToJson(_ToggleLockResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'lockerId': instance.lockerId,
      'requestedState': instance.requestedState,
    };
