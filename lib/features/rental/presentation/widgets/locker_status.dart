import 'package:flutter/material.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/locker_model.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/models/rental_model.dart';

class LockerStatus extends StatelessWidget {
  final LockerModel locker;
  final RentalModel? userRental;

  const LockerStatus({super.key, required this.locker, this.userRental});

  @override
  Widget build(BuildContext context) {
    final isAvailable = locker.lockerRental.isEmpty;
    final isUserRented = userRental != null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.4),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Status Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _getStatusColors(isAvailable, isUserRented),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  _getStatusIcon(isAvailable, isUserRented),
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              // Status Title
              Text(
                _getStatusTitle(isAvailable, isUserRented),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Status Description
              Text(
                _getStatusDescription(isAvailable, isUserRented),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              if (userRental != null) ...[
                const SizedBox(height: 16),
                // Rental Info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rental Started',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            _formatDateTime(userRental!.startTime),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Duration',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            _calculateDuration(userRental!.startTime),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              // Lock Status
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    locker.isOpen ? Icons.lock_open : Icons.lock,
                    color: locker.isOpen
                        ? AppColors.warning
                        : AppColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    locker.isOpen ? 'Unlocked' : 'Locked',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: locker.isOpen
                          ? AppColors.warning
                          : AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> _getStatusColors(bool isAvailable, bool isUserRented) {
    if (isUserRented) {
      return [AppColors.gradientStart, AppColors.gradientEnd];
    } else if (isAvailable) {
      return [AppColors.success, AppColors.success];
    } else {
      return [AppColors.error, AppColors.error];
    }
  }

  IconData _getStatusIcon(bool isAvailable, bool isUserRented) {
    if (isUserRented) {
      return Icons.person;
    } else if (isAvailable) {
      return Icons.check_circle;
    } else {
      return Icons.block;
    }
  }

  String _getStatusTitle(bool isAvailable, bool isUserRented) {
    if (isUserRented) {
      return 'Your Active Rental';
    } else if (isAvailable) {
      return 'Available';
    } else {
      return 'Occupied';
    }
  }

  String _getStatusDescription(bool isAvailable, bool isUserRented) {
    if (isUserRented) {
      return 'You have an active rental on this locker. Use the controls below to manage it.';
    } else if (isAvailable) {
      return 'This locker is available for rent. Tap the rent button below to start your rental.';
    } else {
      return 'This locker is currently occupied by another user. Please try another locker.';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _calculateDuration(DateTime startTime) {
    final now = DateTime.now();
    final difference = now.difference(startTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ${difference.inHours % 24}h';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ${difference.inMinutes % 60}m';
    } else {
      return '${difference.inMinutes}m';
    }
  }
}
