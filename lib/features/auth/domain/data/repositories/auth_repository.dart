import 'package:dio/dio.dart';
import 'package:nexlock_app_v2/core/handlers/dio_exception_handler.dart';
import 'package:nexlock_app_v2/core/handlers/dio_handler.dart';
import 'package:nexlock_app_v2/core/handlers/secure_storage_handler.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/models/user_jwt_model.dart';

class AuthRepository {
  final SecureStorage _secureStorage = SecureStorage();
  final DioClient _dio = DioClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.instance.post(
        '/user/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final token = responseData['access_token'];
          if (token != null && token is String) {
            await _secureStorage.setToken(token);
          }
        }
      }

      return response.data;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = parseDioError(e);
        throw Exception(errorMessage);
      } else if (e is StateError) {
        throw Exception(
          'Network client initialization failed. Please try again.',
        );
      } else {
        throw Exception('An unexpected error occurred: $e');
      }
    }
  }

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final response = await _dio.instance.post(
        '/user/register',
        data: {'email': email, 'password': password, 'name': name},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final token = responseData['access_token'];
          if (token != null && token is String) {
            await _secureStorage.setToken(token);
          }
        }
      }

      return response.data;
    } catch (e) {
      if (e is DioException) {
        final errorMessage = parseDioError(e);
        throw Exception(errorMessage);
      } else if (e is StateError) {
        throw Exception(
          'Network client initialization failed. Please try again.',
        );
      } else {
        throw Exception('An unexpected error occurred: $e');
      }
    }
  }

  Future<UserJwtModel> getUserFromToken() async {
    try {
      final token = await _secureStorage.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('User not found. Please log in again.');
      }

      final response = await _dio.instance.get(
        '/user/info',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return UserJwtModel.fromJson(response.data);
    } catch (e) {
      if (e is DioException) {
        final errorMessage = parseDioError(e);
        throw Exception(errorMessage);
      } else if (e is StateError) {
        throw Exception(
          'Network client initialization failed. Please try again.',
        );
      } else {
        throw Exception('An unexpected error occurred: $e');
      }
    }
  }
}
