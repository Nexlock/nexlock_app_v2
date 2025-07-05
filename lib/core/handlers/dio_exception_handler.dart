import 'package:dio/dio.dart';

String parseDioError(DioException e) {
  String errorMessage = 'An unexpected error occurred';

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      errorMessage =
          'Connection timeout (2 minutes). Server may be slow or unreachable. Please check your internet connection and try again.';
      break;
    case DioExceptionType.sendTimeout:
      errorMessage = 'Request timeout (2 minutes). Please try again.';
      break;
    case DioExceptionType.receiveTimeout:
      errorMessage =
          'Server response timeout (3 minutes). The server may be processing your request. Please try again.';
      break;
    case DioExceptionType.badResponse:
      if (e.response?.statusCode == 401) {
        errorMessage = 'Invalid credentials';
        final errorData = e.response?.data;

        if (errorData != null && errorData['message'] != null) {
          if (errorData['message'] is List) {
            errorMessage = errorData['message'][0]?.toString() ?? errorMessage;
          } else if (errorData['message'] is String) {
            errorMessage = errorData['message'];
          }
        }
      } else if (e.response?.statusCode == 422) {
        errorMessage = 'Invalid input data. Please check your information.';
        final errorData = e.response?.data;
        if (errorData != null && errorData['message'] != null) {
          errorMessage = errorData['message'].toString();
        }
      } else if (e.response?.statusCode == 500) {
        errorMessage = 'Server error. Please try again later.';
      } else {
        errorMessage = 'Request failed with status ${e.response?.statusCode}';
      }
      break;
    case DioExceptionType.cancel:
      errorMessage = 'Request was cancelled';
      break;
    case DioExceptionType.connectionError:
      errorMessage =
          'Connection error. Please check your internet connection and server availability.';
      break;
    case DioExceptionType.unknown:
      errorMessage =
          'Network error. Please check your connection and server status.';
      break;
    case DioExceptionType.badCertificate:
      errorMessage =
          'Certificate verification failed. Please check your connection.';
      break;
  }

  // Add the actual error details for debugging
  print('DioException details: ${e.toString()}');
  if (e.response != null) {
    print('Response status: ${e.response?.statusCode}');
    print('Response data: ${e.response?.data}');
  }

  return errorMessage;
}
