import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';
import 'package:nexlock_app_v2/features/module/domain/data/models/module_model.dart';
import 'package:nexlock_app_v2/features/module_list/domain/data/repositories/module_list_repository.dart';
import 'package:nexlock_app_v2/features/module_list/presentation/widgets/module_list_filter.dart';
import 'package:nexlock_app_v2/features/module_list/presentation/widgets/module_bottom_sheet.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';

class ModuleListScreen extends ConsumerStatefulWidget {
  const ModuleListScreen({super.key});

  @override
  ConsumerState<ModuleListScreen> createState() => _ModuleListScreenState();
}

class _ModuleListScreenState extends ConsumerState<ModuleListScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  bool _isLoadingLocation = true;
  bool _isLoadingModules = false;
  String? _locationError;
  List<ModuleModel> _modules = [];
  double _searchRadius = 5.0; // Default 5km
  Set<Marker> _markers = {};

  final ModuleListRepository _moduleRepository = ModuleListRepository();
  BitmapDescriptor? _customMarkerIcon;

  bool _isMapReady = false;
  String? _mapError;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    _initializeLocation();
  }

  Future<void> _loadCustomMarker() async {
    _customMarkerIcon = await _createCustomMarkerIcon();
  }

  Future<BitmapDescriptor> _createCustomMarkerIcon() async {
    final ByteData data = await rootBundle.load('assets/logo-only.png');
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: 100,
      targetHeight: 100,
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? resizedData = await frameInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return BitmapDescriptor.fromBytes(resizedData!.buffer.asUint8List());
  }

  Future<void> _initializeLocation() async {
    try {
      setState(() {
        _isLoadingLocation = true;
        _locationError = null;
      });

      // Check location permission
      final permission = await Permission.location.request();
      if (!permission.isGranted) {
        throw Exception('Location permission denied');
      }

      // Check if location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw Exception('Location services are disabled');
      }

      // Get current position
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Load modules near current location
      await _loadModules();

      setState(() {
        _isLoadingLocation = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
        _locationError = e.toString();
      });
    }
  }

  Future<void> _loadModules() async {
    if (_currentPosition == null) return;

    try {
      setState(() {
        _isLoadingModules = true;
      });

      // Convert km to degrees using proper formula
      // 1 degree latitude ≈ 111 km
      // 1 degree longitude ≈ 111 km * cos(latitude)
      final radiusInDegrees = _searchRadius / 111.0;

      final modules = await _moduleRepository.getModulesByLocation(
        latitude: _currentPosition!.latitude,
        longitude: _currentPosition!.longitude,
        radius: radiusInDegrees,
      );

      setState(() {
        _modules = modules;
        _isLoadingModules = false;
      });

      _updateMarkers();
    } catch (e) {
      setState(() {
        _isLoadingModules = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading modules: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _updateMarkers() {
    final markers = <Marker>{};

    // Add user location marker
    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(
            title: 'Your Location',
            snippet: 'You are here',
          ),
        ),
      );
    }

    // Add module markers with custom icon
    for (final module in _modules) {
      markers.add(
        Marker(
          markerId: MarkerId(module.id),
          position: LatLng(module.latitude, module.longitude),
          icon:
              _customMarkerIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: InfoWindow(
            title: module.name,
            snippet: '${module.lockers.length} lockers available',
          ),
          onTap: () => _showModuleBottomSheet(module),
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  void _showModuleBottomSheet(ModuleModel module) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          ModuleBottomSheet(module: module, currentPosition: _currentPosition),
    );
  }

  void _centerMapOnUser() {
    if (_currentPosition != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          15.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find NexLock Modules'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadModules),
        ],
      ),
      body: Column(
        children: [
          // Filter section
          ModuleListFilter(
            currentRadius: _searchRadius,
            onRadiusChanged: (radius) {
              setState(() {
                _searchRadius = radius;
              });
            },
            onFilterApplied: _loadModules,
          ),
          // Map section
          Expanded(
            child: _isLoadingLocation
                ? const Center(child: CircularProgressIndicator())
                : _locationError != null
                ? _buildErrorWidget()
                : _buildMapWidget(),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'center_user',
            onPressed: _centerMapOnUser,
            backgroundColor: AppColors.lightPrimary,
            child: const Icon(Icons.my_location, color: Colors.white),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'refresh_modules',
            onPressed: _isLoadingModules ? null : _loadModules,
            backgroundColor: AppColors.lightPrimary,
            child: _isLoadingModules
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Location Error',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              _locationError ?? 'Unable to get your location',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _initializeLocation,
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

  Widget _buildMapWidget() {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) async {
            try {
              _mapController = controller;
              setState(() {
                _isMapReady = true;
                _mapError = null;
              });
              print('Google Maps initialized successfully');
            } catch (e) {
              setState(() {
                _mapError = 'Failed to initialize map: $e';
              });
              print('Google Maps error: $e');
            }
          },
          initialCameraPosition: _currentPosition != null
              ? CameraPosition(
                  target: LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  ),
                  zoom: 13.0,
                )
              : const CameraPosition(
                  target: LatLng(14.5995, 120.9842), // Manila, Philippines
                  zoom: 13.0,
                ),
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          // Optimize for better performance
          liteModeEnabled: false,
          trafficEnabled: false,
          buildingsEnabled: true,
          indoorViewEnabled: false,
          tiltGesturesEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onTap: (position) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        // Error overlay for map issues
        if (_mapError != null)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Map Error',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        _mapError!,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _mapError = null;
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightPrimary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        // Module count overlay
        if (_modules.isNotEmpty && _isMapReady)
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(22.4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_modules.length} modules found',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_modules.fold(0, (sum, module) => sum + module.lockers.where((l) => l.lockerRental.isEmpty).length)} available',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        // Loading overlay
        if (_isLoadingModules)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
