import 'package:freezed_annotation/freezed_annotation.dart';

part 'toggle_lock_response.freezed.dart';
part 'toggle_lock_response.g.dart';

@freezed
sealed class ToggleLockResponse with _$ToggleLockResponse {
  const factory ToggleLockResponse({
    required bool success,
    required String message,
    required String lockerId,
    required bool requestedState,
  }) = _ToggleLockResponse;

  factory ToggleLockResponse.fromJson(Map<String, dynamic> json) =>
      _$ToggleLockResponseFromJson(json);
}
