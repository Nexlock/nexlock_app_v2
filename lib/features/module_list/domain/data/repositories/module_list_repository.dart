import 'package:nexlock_app_v2/core/handlers/dio_handler.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/module_model.dart';

class ModuleListRepository {
  final DioClient _dio = DioClient();

  Future<List<ModuleModel>> getModulesByLocation({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    try {
      final response = await _dio.instance.post(
        '/module/search',
        data: {'latitude': latitude, 'longitude': longitude, 'radius': radius},
      );
      return (response.data as List)
          .map((item) => ModuleModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Error fetching modules by location: $e');
    }
  }
}
