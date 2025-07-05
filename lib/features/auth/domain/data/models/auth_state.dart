import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/models/user_jwt_model.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    UserJwtModel? user,
    @Default(false) bool isAuthenticated,
    @Default(false) bool isLoading,
    String? error,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
