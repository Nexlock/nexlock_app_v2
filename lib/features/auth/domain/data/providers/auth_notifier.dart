import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexlock_app_v2/core/handlers/secure_storage_handler.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/models/auth_state.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/models/user_jwt_model.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/repositories/auth_repository.dart';

class AuthNotifier extends AsyncNotifier<AuthState> {
  final SecureStorage _secureStorage = SecureStorage();
  final AuthRepository _authRepository = AuthRepository();

  @override
  Future<AuthState> build() async {
    final token = await _secureStorage.getToken();

    if (token != null) {
      try {
        final userData = await _authRepository.getUserFromToken();
        return AuthState(
          user: userData,
          isAuthenticated: true,
          isLoading: false,
        );
      } catch (e) {
        await _secureStorage.deleteToken();
        return AuthState(isAuthenticated: false, error: e.toString());
      }
    }
    return const AuthState(isAuthenticated: false);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.data(AuthState(isLoading: true));

    state = await AsyncValue.guard(() async {
      try {
        final response = await _authRepository.login(email, password);
        final user = UserJwtModel.fromJson(response);
        return AuthState(user: user, isAuthenticated: true, isLoading: false);
      } catch (e) {
        return AuthState(isAuthenticated: false, error: e.toString());
      }
    });
  }

  Future<void> register(String email, String password, String name) async {
    state = const AsyncValue.data(AuthState(isLoading: true));

    state = await AsyncValue.guard(() async {
      try {
        final response = await _authRepository.register(email, password, name);
        final user = UserJwtModel.fromJson(response);
        return AuthState(user: user, isAuthenticated: true, isLoading: false);
      } catch (e) {
        return AuthState(isAuthenticated: false, error: e.toString());
      }
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.data(AuthState(isLoading: true));

    state = await AsyncValue.guard(() async {
      try {
        await _secureStorage.deleteToken();
        return const AuthState(isAuthenticated: false, isLoading: false);
      } catch (e) {
        return AuthState(isAuthenticated: true, error: e.toString());
      }
    });
  }

  Future<UserJwtModel?> getUser() async {
    final token = await _secureStorage.getToken();
    if (token != null) {
      try {
        final userData = await _authRepository.getUserFromToken();
        return userData;
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
);
