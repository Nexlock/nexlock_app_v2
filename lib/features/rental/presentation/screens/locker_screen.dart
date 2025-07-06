import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/locker_model.dart';
import 'package:nexlock_app_v2/features/module/domain/data/repositories/module_repository.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/models/rental_model.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/providers/rental_notifier.dart';
import 'package:nexlock_app_v2/features/rental/presentation/widgets/locker_controls.dart';
import 'package:nexlock_app_v2/features/rental/presentation/widgets/locker_status.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/providers/auth_notifier.dart';

class LockerScreen extends ConsumerStatefulWidget {
  final String lockerId;

  const LockerScreen({super.key, required this.lockerId});

  @override
  ConsumerState<LockerScreen> createState() => _LockerScreenState();
}

class _LockerScreenState extends ConsumerState<LockerScreen> {
  final ModuleRepository _moduleRepository = ModuleRepository();

  LockerModel? _locker;
  RentalModel? _userRental;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadLockerData();
  }

  Future<void> _loadLockerData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final authState = ref.read(authProvider).value;
      final userId = authState?.user?.id;

      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Get locker data directly from module repository
      final locker = await _moduleRepository.getLockerById(widget.lockerId);

      // Get active rentals to check if user has rental on this locker
      final rentalState = ref.read(rentalProvider).value;
      final allRentals = rentalState?.activeRentals ?? [];

      // Check if current user has an active rental on this locker
      RentalModel? userRental;
      try {
        userRental = allRentals.firstWhere(
          (r) => r.lockerId == widget.lockerId && r.userId == userId,
        );
      } catch (e) {
        // No rental found, userRental remains null
        userRental = null;
      }

      setState(() {
        _locker = locker;
        _userRental = userRental;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _onRentalUpdated() async {
    // Refresh rental data
    await ref.read(rentalProvider.notifier).fetchActiveRentals();
    // Reload locker data
    await _loadLockerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locker #${widget.lockerId.substring(0, 8)}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadLockerData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _buildErrorWidget()
          : _locker != null
          ? _buildLockerContent()
          : _buildNotFoundWidget(),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error Loading Locker',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              _error ?? 'Unknown error occurred',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadLockerData,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightPrimary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotFoundWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Locker Not Found',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'The requested locker could not be found or is no longer available.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Go Back'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightPrimary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockerContent() {
    return RefreshIndicator(
      onRefresh: _loadLockerData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Reduced spacing
            // Locker Status
            LockerStatus(locker: _locker!, userRental: _userRental),
            const SizedBox(height: 32), // Reduced spacing
            // Locker Controls
            LockerControls(
              locker: _locker!,
              userRental: _userRental,
              onRentalUpdated: _onRentalUpdated,
            ),
            const SizedBox(height: 32), // Reduced spacing
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.lightPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.lightPrimary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
