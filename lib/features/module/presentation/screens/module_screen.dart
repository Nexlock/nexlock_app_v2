import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';
import 'package:nexlock_app_v2/core/services/websocket_service.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/module_model.dart';
import 'package:nexlock_app_v2/features/module/domain/data/repositories/module_repository.dart';
import 'package:nexlock_app_v2/features/module/presentation/widgets/module_lockers.dart';
import 'package:nexlock_app_v2/features/module/presentation/widgets/module_status.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/providers/rental_notifier.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';

class ModuleScreen extends ConsumerStatefulWidget {
  final String moduleId;

  const ModuleScreen({super.key, required this.moduleId});

  @override
  ConsumerState<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends ConsumerState<ModuleScreen> {
  final ModuleRepository _moduleRepository = ModuleRepository();
  final WebSocketService _webSocketService = WebSocketService();

  ModuleModel? _module;
  bool _isConnected = false;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeWebSocket();
    _loadModuleData();
    _startPeriodicRefresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initializeWebSocket() async {
    try {
      final serverUrl = dotenv.env['API_URL'] ?? '';

      print('Connecting to WebSocket at: $serverUrl');

      if (!_webSocketService.isConnected) {
        await _webSocketService.connect(serverUrl);
      }

      // Request initial connection status and specific module status
      await Future.delayed(const Duration(seconds: 2));
      print('Requesting connection status for module: ${widget.moduleId}');
      _webSocketService.requestConnectionStatus();
      _webSocketService.requestModuleStatus(widget.moduleId);

      // Update status after a delay
      Timer(const Duration(seconds: 1), () {
        _updateConnectionStatus();
      });
    } catch (e) {
      print('WebSocket initialization failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Connection failed: ${e.toString()}. Check if server is running on your network.',
            ),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  void _startPeriodicRefresh() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _refreshModuleStatus();
    });
  }

  Future<void> _loadModuleData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final module = await _moduleRepository.getModuleById(widget.moduleId);

      setState(() {
        _module = module;
        _isLoading = false;
      });

      // Refresh rental data and check connection status
      if (mounted) {
        ref.read(rentalProvider.notifier).fetchActiveRentals();
        _updateConnectionStatus();
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshModuleStatus() async {
    if (_module != null) {
      try {
        print('Refreshing module status for: ${widget.moduleId}');
        // Request both general connection status and specific module status
        _webSocketService.requestConnectionStatus();
        _webSocketService.requestModuleStatus(widget.moduleId);

        // Update connection status after multiple delays to catch the response
        Timer(const Duration(milliseconds: 200), () {
          _updateConnectionStatus();
        });

        Timer(const Duration(seconds: 1), () {
          _updateConnectionStatus();
        });

        Timer(const Duration(seconds: 3), () {
          _updateConnectionStatus();
        });
      } catch (e) {
        print('Error refreshing module status: $e');
      }
    }
  }

  void _updateConnectionStatus() {
    final connectionStatus = _webSocketService.getModuleConnectionStatus(
      widget.moduleId,
    );

    print(
      'Checking connection status for ${widget.moduleId}: $connectionStatus',
    );

    if (mounted) {
      setState(() {
        _isConnected = connectionStatus;
      });
      print(
        'Module ${widget.moduleId} UI connection status updated: $_isConnected',
      );
    }
  }

  Future<void> _onRefresh() async {
    await _loadModuleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NexLock'),
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
            const SizedBox(height: 20), // Reduced top spacing
            // Module Status
            ModuleStatus(module: _module!, isConnected: _isConnected),
            const SizedBox(height: 32), // Reduced spacing
            // Module Lockers
            ModuleLockers(lockers: _module!.lockers),
            const SizedBox(height: 32), // Reduced bottom spacing
          ],
        ),
      ),
    );
  }
}
