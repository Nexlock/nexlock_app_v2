import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/models/rental_state.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/repositories/rental_repository.dart';

class RentalNotifier extends AsyncNotifier<RentalState> {
  final RentalRepository _rentalRepository = RentalRepository();

  @override
  Future<RentalState> build() async {
    try {
      final activeRentals = await _rentalRepository.getActiveRentals();
      return RentalState(activeRentals: activeRentals, isLoading: false);
    } catch (e) {
      return RentalState(
        activeRentals: [],
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> fetchActiveRentals() async {
    state = const AsyncValue<RentalState>.loading();

    state = await AsyncValue.guard(() async {
      try {
        final activeRentals = await _rentalRepository.getActiveRentals();
        return RentalState(activeRentals: activeRentals, isLoading: false);
      } catch (e) {
        return RentalState(
          activeRentals: [],
          isLoading: false,
          error: e.toString(),
        );
      }
    });
  }

  Future<void> rentLocker(String lockerId) async {
    state = const AsyncValue<RentalState>.loading();

    state = await AsyncValue.guard(() async {
      try {
        final rental = await _rentalRepository.rentLocker(lockerId);
        final updatedRentals = [...state.value?.activeRentals ?? [], rental];
        return RentalState(activeRentals: updatedRentals, isLoading: false);
      } catch (e) {
        return RentalState(
          activeRentals: [],
          isLoading: false,
          error: e.toString(),
        );
      }
    });
  }

  Future<void> checkoutLocker(String rentalId) async {
    state = const AsyncValue<RentalState>.loading();

    state = await AsyncValue.guard(() async {
      try {
        final rental = await _rentalRepository.checkoutLocker(rentalId);
        final updatedRentals =
            state.value?.activeRentals
                .where((r) => r.id != rental.id)
                .toList() ??
            [];
        return RentalState(activeRentals: updatedRentals, isLoading: false);
      } catch (e) {
        return RentalState(
          activeRentals: [],
          isLoading: false,
          error: e.toString(),
        );
      }
    });
  }
}

final rentalProvider = AsyncNotifierProvider<RentalNotifier, RentalState>(
  () => RentalNotifier(),
);
