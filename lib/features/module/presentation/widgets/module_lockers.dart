import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/locker_model.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/providers/rental_notifier.dart';

class ModuleLockers extends ConsumerWidget {
  final List<LockerModel> lockers;

  const ModuleLockers({super.key, required this.lockers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rentalState = ref.watch(rentalProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lockers',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          if (lockers.isEmpty)
            _EmptyLockersCard()
          else
            Column(
              children: lockers.asMap().entries.map((entry) {
                final index = entry.key;
                final locker = entry.value;

                return rentalState.when(
                  data: (state) {
                    final userRental = state.activeRentals
                        .where((r) => r.lockerId == locker.id)
                        .firstOrNull;

                    return _LockerCard(
                      locker: locker,
                      lockerNumber: index + 1,
                      hasUserRental: userRental != null,
                    );
                  },
                  loading: () => _LockerCard(
                    locker: locker,
                    lockerNumber: index + 1,
                    hasUserRental: false,
                  ),
                  error: (_, __) => _LockerCard(
                    locker: locker,
                    lockerNumber: index + 1,
                    hasUserRental: false,
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _LockerCard extends StatelessWidget {
  final LockerModel locker;
  final int lockerNumber;
  final bool hasUserRental;

  const _LockerCard({
    required this.locker,
    required this.lockerNumber,
    required this.hasUserRental,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = locker.lockerRental.isEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.4),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          ),
        ),
        child: InkWell(
          onTap: () {
            context.push('/locker/${locker.id}');
          },
          borderRadius: BorderRadius.circular(22.4),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Locker Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getStatusGradient(isAvailable, hasUserRental),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getStatusIcon(isAvailable, hasUserRental),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Locker Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Locker #$lockerNumber',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            locker.isOpen ? Icons.lock_open : Icons.lock,
                            size: 16,
                            color: locker.isOpen
                                ? AppColors.warning
                                : AppColors.success,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            locker.isOpen ? 'Unlocked' : 'Locked',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: locker.isOpen
                                      ? AppColors.warning
                                      : AppColors.success,
                                ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'ID: ${locker.id.substring(0, 8)}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      isAvailable,
                      hasUserRental,
                    ).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(isAvailable, hasUserRental),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _getStatusColor(isAvailable, hasUserRental),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getStatusGradient(bool isAvailable, bool hasUserRental) {
    if (hasUserRental) {
      return [AppColors.gradientStart, AppColors.gradientEnd];
    } else if (isAvailable) {
      return [AppColors.success, AppColors.success];
    } else {
      return [AppColors.error, AppColors.error];
    }
  }

  IconData _getStatusIcon(bool isAvailable, bool hasUserRental) {
    if (hasUserRental) {
      return Icons.person;
    } else if (isAvailable) {
      return Icons.lock_open;
    } else {
      return Icons.lock;
    }
  }

  Color _getStatusColor(bool isAvailable, bool hasUserRental) {
    if (hasUserRental) {
      return AppColors.lightPrimary;
    } else if (isAvailable) {
      return AppColors.success;
    } else {
      return AppColors.error;
    }
  }

  String _getStatusText(bool isAvailable, bool hasUserRental) {
    if (hasUserRental) {
      return 'Your Rental';
    } else if (isAvailable) {
      return 'Available';
    } else {
      return 'Occupied';
    }
  }
}

class _EmptyLockersCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.4),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No Lockers Available',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'This module doesn\'t have any lockers configured yet.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
