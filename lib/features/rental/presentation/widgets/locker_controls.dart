import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/locker_model.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/models/rental_model.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/providers/rental_notifier.dart';
import 'package:nexlock_app_v2/features/module/domain/data/repositories/module_repository.dart';

class LockerControls extends ConsumerStatefulWidget {
  final LockerModel locker;
  final RentalModel? userRental;
  final VoidCallback? onRentalUpdated;

  const LockerControls({
    super.key,
    required this.locker,
    this.userRental,
    this.onRentalUpdated,
  });

  @override
  ConsumerState<LockerControls> createState() => _LockerControlsState();
}

class _LockerControlsState extends ConsumerState<LockerControls> {
  bool _isToggling = false;
  bool _isRenting = false;
  bool _isCheckingOut = false;

  final ModuleRepository _moduleRepository = ModuleRepository();

  Future<void> _toggleLock() async {
    if (_isToggling) return;

    setState(() {
      _isToggling = true;
    });

    try {
      final response = await _moduleRepository.toggleLockerLock(
        widget.locker.id,
        !widget.locker.isOpen,
      );

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            backgroundColor: AppColors.success,
          ),
        );
        widget.onRentalUpdated?.call();
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
      );
    } finally {
      setState(() {
        _isToggling = false;
      });
    }
  }

  Future<void> _rentLocker() async {
    if (_isRenting) return;

    setState(() {
      _isRenting = true;
    });

    try {
      await ref.read(rentalProvider.notifier).rentLocker(widget.locker.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Locker rented successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      widget.onRentalUpdated?.call();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error renting locker: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isRenting = false;
      });
    }
  }

  Future<void> _checkoutLocker() async {
    if (_isCheckingOut || widget.userRental == null) return;

    setState(() {
      _isCheckingOut = true;
    });

    try {
      await ref
          .read(rentalProvider.notifier)
          .checkoutLocker(widget.userRental!.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Checkout successful!'),
          backgroundColor: AppColors.success,
        ),
      );
      widget.onRentalUpdated?.call();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error checking out: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isCheckingOut = false;
      });
    }
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.4),
        ),
        title: const Text('Checkout Locker'),
        content: const Text(
          'Are you sure you want to checkout? This will end your rental and you will no longer have access to this locker.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _checkoutLocker();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAvailable = widget.locker.lockerRental.isEmpty;
    final isUserRented = widget.userRental != null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isUserRented) ...[
            // User has rented this locker - show controls
            Text(
              'Locker Controls',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isToggling ? null : _toggleLock,
                    icon: _isToggling
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            widget.locker.isOpen ? Icons.lock : Icons.lock_open,
                          ),
                    label: Text(widget.locker.isOpen ? 'Lock' : 'Unlock'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isCheckingOut ? null : _showCheckoutDialog,
                    icon: _isCheckingOut
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.exit_to_app),
                    label: const Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else if (isAvailable) ...[
            // Locker is available - show rent button
            Text(
              'Rent This Locker',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isRenting ? null : _rentLocker,
                icon: _isRenting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.add_circle),
                label: const Text('Rent Locker'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.4),
                  ),
                ),
              ),
            ),
          ] else ...[
            // Locker is occupied - show message
            Card(
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
                    Icon(
                      Icons.info_outline,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Locker Not Available',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This locker is currently occupied by another user. Please try another locker.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
