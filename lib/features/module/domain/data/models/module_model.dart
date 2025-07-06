import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/locker_model.dart';

part 'module_model.freezed.dart';
part 'module_model.g.dart';

@freezed
sealed class ModuleModel with _$ModuleModel {
  const factory ModuleModel({
    required String id,
    required String name,
    required String description,
    required String location,
    required double latitude,
    required double longitude,
    @Default([]) List<LockerModel> lockers,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ModuleModel;

  factory ModuleModel.fromJson(Map<String, dynamic> json) =>
      _$ModuleModelFromJson(json);
}
