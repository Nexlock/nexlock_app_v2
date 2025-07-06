import 'package:nexlock_app_v2/core/handlers/dio_handler.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/models/rental_model.dart';

class RentalRepository {
  final DioClient _dio = DioClient();

  Future<List<RentalModel>> getAllRentals() async {
    try {
      final response = await _dio.instance.get('/rental/user');
      return (response.data as List)
          .map((item) => RentalModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Error fetching rentals: $e');
    }
  }

  Future<List<RentalModel>> getRentalById(String rentalId) async {
    try {
      final response = await _dio.instance.get('/rental/$rentalId');
      return (response.data as List)
          .map((item) => RentalModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Error fetching rental by ID: $e');
    }
  }

  Future<List<RentalModel>> getActiveRentals() async {
    try {
      final response = await _dio.instance.get('/rental/active');
      return (response.data as List)
          .map((item) => RentalModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Error fetching active rentals: $e');
    }
  }

  Future<RentalModel> rentLocker(String lockerId) async {
    try {
      final response = await _dio.instance.post('/rental/rent/$lockerId');
      return RentalModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error renting locker: $e');
    }
  }

  Future<RentalModel> checkoutLocker(String lockerId) async {
    try {
      final response = await _dio.instance.post('/rental/checkout/$lockerId');
      return RentalModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error checking out rental: $e');
    }
  }
}
