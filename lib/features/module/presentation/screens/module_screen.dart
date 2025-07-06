import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/module_model.dart';
import 'package:nexlock_app_v2/features/module/domain/data/repositories/module_repository.dart';
import 'package:nexlock_app_v2/features/module/presentation/widgets/module_lockers.dart';
import 'package:nexlock_app_v2/features/module/presentation/widgets/module_status.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/providers/rental_notifier.dart';

class ModuleScreen extends ConsumerStatefulWidget {
  final String moduleId;

  const ModuleScreen({super.key, required this.moduleId});

  @override
  ConsumerState<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends ConsumerState<ModuleScreen> {
  final ModuleRepository _moduleRepository = ModuleRepository();

  ModuleModel? _module;
  bool _isConnected = false;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadModuleData();
    _startPeriodicRefresh();
  }

  void _startPeriodicRefresh() {
    // Refresh data every 30 seconds for real-time updates
    Future.doWhile(() async {
      if (!mounted) return false;
      await Future.delayed(const Duration(seconds: 30));
      if (mounted) {
        _refreshModuleStatus();
      }
      return mounted;
    });
  }

  Future<void> _loadModuleData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final module = await _moduleRepository.getModuleById(widget.moduleId);

      if (module == null) {
        throw Exception('Module not found');
      }

      // TODO: Implement real-time connection status check
      // For now, we'll simulate connection status
      final connectionStatus = await _checkConnectionStatus();

      setState(() {
        _module = module;
        _isConnected = connectionStatus;
        _isLoading = false;
      });

      // Refresh rental data to get latest locker statuses
      if (mounted) {
        ref.read(rentalProvider.notifier).fetchActiveRentals();
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<bool> _checkConnectionStatus() async {
    // TODO: Implement actual WebSocket connection check
    // This would check if the module is connected via WebSocket
    try {
      // Simulate connection check
      await Future.delayed(const Duration(milliseconds: 500));
      return true; // For demo purposes
    } catch (e) {
      return false;
    }
  }

  Future<void> _refreshModuleStatus() async {
    if (_module != null) {
      try {
        final connectionStatus = await _checkConnectionStatus();
        if (mounted) {
          setState(() {
            _isConnected = connectionStatus;
          });
        }
      } catch (e) {
        // Silently handle connection check errors
      }
    }
  }

  Future<void> _onRefresh() async {
    await _loadModuleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_module?.name ?? 'Module'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _onRefresh),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _buildErrorWidget()
          : _module != null
          ? _buildModuleContent()
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
            'Error Loading Module',
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
            onPressed: _onRefresh,
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
            'Module Not Found',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'The requested module could not be found or is no longer available.',
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

  Widget _buildModuleContent() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Module Status
            ModuleStatus(module: _module!, isConnected: _isConnected),
            const SizedBox(height: 32),
            // Module Lockers
            ModuleLockers(lockers: _module!.lockers),
            const SizedBox(height: 32),
            // Additional Module Info
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Module Information',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.4),
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withOpacity(0.1),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _InfoRow(
                            icon: Icons.fingerprint,
                            label: 'Module ID',
                            value: widget.moduleId,
                          ),
                          const SizedBox(height: 16),
                          _InfoRow(
                            icon: Icons.access_time,
                            label: 'Last Updated',
                            value: _formatDateTime(_module!.updatedAt),
                          ),
                          const SizedBox(height: 16),
                          _InfoRow(
                            icon: Icons.location_on,
                            label: 'Coordinates',
                            value:
                                '${_module!.latitude.toStringAsFixed(4)}, ${_module!.longitude.toStringAsFixed(4)}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
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
