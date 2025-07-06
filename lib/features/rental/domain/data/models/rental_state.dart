import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/models/rental_model.dart';

part 'rental_state.freezed.dart';
part 'rental_state.g.dart';

@freezed
sealed class RentalState with _$RentalState {
  const factory RentalState({
    required List<RentalModel> activeRentals,
    @Default(false) bool isLoading,
    String? error,
  }) = _RentalState;

  factory RentalState.fromJson(Map<String, dynamic> json) =>
      _$RentalStateFromJson(json);
}
