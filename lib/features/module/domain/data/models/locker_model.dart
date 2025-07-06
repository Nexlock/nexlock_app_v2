import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/models/rental_model.dart';

part 'locker_model.freezed.dart';
part 'locker_model.g.dart';

@freezed
sealed class LockerModel with _$LockerModel {
  const factory LockerModel({
    required String id,
    required String moduleId,
    required bool isOpen,
    @Default([]) List<RentalModel> lockerRental,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LockerModel;

  factory LockerModel.fromJson(Map<String, dynamic> json) =>
      _$LockerModelFromJson(json);
}
