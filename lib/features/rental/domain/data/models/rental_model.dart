import 'package:freezed_annotation/freezed_annotation.dart';

part 'rental_model.freezed.dart';
part 'rental_model.g.dart';

@freezed
sealed class RentalModel with _$RentalModel {
  const factory RentalModel({
    required String id,
    required String userId,
    required String lockerId,
    required DateTime startTime,
    DateTime? endTime,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RentalModel;

  factory RentalModel.fromJson(Map<String, dynamic> json) =>
      _$RentalModelFromJson(json);
}
