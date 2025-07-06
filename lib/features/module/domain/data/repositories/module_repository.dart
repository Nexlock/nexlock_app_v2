import 'package:nexlock_app_v2/core/handlers/dio_handler.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/module_model.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/toggle_lock_response.dart';

class ModuleRepository {
  final DioClient _dio = DioClient();

  Future<ModuleModel> getModuleById(String moduleId) async {
    try {
      final response = await _dio.instance.get('/module/$moduleId');
      return ModuleModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Error fetching module by ID: $e');
    }
  }

  Future<ToggleLockResponse> toggleLockerLock(
    String lockerId,
    bool isOpen,
  ) async {
    try {
      final response = await _dio.instance.post(
        '/module/toggle-lock/user',
        data: {'lockerId': lockerId, 'isOpen': isOpen},
      );
      return ToggleLockResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Error toggling locker lock: $e');
    }
  }
}
