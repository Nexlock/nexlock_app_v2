// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RentalState _$RentalStateFromJson(Map<String, dynamic> json) => _RentalState(
  activeRentals: (json['activeRentals'] as List<dynamic>)
      .map((e) => RentalModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  isLoading: json['isLoading'] as bool? ?? false,
  error: json['error'] as String?,
);

Map<String, dynamic> _$RentalStateToJson(_RentalState instance) =>
    <String, dynamic>{
      'activeRentals': instance.activeRentals,
      'isLoading': instance.isLoading,
      'error': instance.error,
    };
