import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/models/rental_model.dart';
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
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      try {
        await _rentalRepository.rentLocker(lockerId);
        final updatedRentals = await _rentalRepository.getActiveRentals();
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

  Future<void> checkoutLocker(String lockerId) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      try {
        await _rentalRepository.checkoutLocker(lockerId);
        final updatedRentals = await _rentalRepository.getActiveRentals();
        return RentalState(activeRentals: updatedRentals, isLoading: false);
      } catch (e) {
        // Get current state to preserve data on error
        final currentState = state.value;
        return RentalState(
          activeRentals: currentState?.activeRentals ?? [],
          isLoading: false,
          error: e.toString(),
        );
      }
    });
  }

  Future<List<RentalModel>> getAllRentals() async {
    try {
      return await _rentalRepository.getAllRentals();
    } catch (e) {
      throw Exception('Error fetching all rentals: $e');
    }
  }
}

final rentalProvider = AsyncNotifierProvider<RentalNotifier, RentalState>(
  () => RentalNotifier(),
);
