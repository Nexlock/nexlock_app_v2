import 'package:flutter/material.dart';
import 'package:nexlock_app_v2/core/constants/colors.dart';

class ModuleListFilter extends StatefulWidget {
  final double currentRadius;
  final ValueChanged<double> onRadiusChanged;
  final VoidCallback onFilterApplied;

  const ModuleListFilter({
    super.key,
    required this.currentRadius,
    required this.onRadiusChanged,
    required this.onFilterApplied,
  });

  @override
  State<ModuleListFilter> createState() => _ModuleListFilterState();
}

class _ModuleListFilterState extends State<ModuleListFilter> {
  late double _tempRadius;
  final List<double> _presetRadii = [0.5, 1.0, 2.0, 5.0, 10.0]; // km

  @override
  void initState() {
    super.initState();
    _tempRadius = widget.currentRadius;
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(22.4),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter by Distance',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _tempRadius = 5.0; // Reset to default
                        });
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Distance display
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.lightPrimary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search Radius',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '${_tempRadius.toStringAsFixed(1)} km',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightPrimary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Slider
                      Text(
                        'Adjust Distance',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: AppColors.lightPrimary,
                          thumbColor: AppColors.lightPrimary,
                          overlayColor: AppColors.lightPrimary.withOpacity(0.1),
                          inactiveTrackColor: AppColors.lightPrimary
                              .withOpacity(0.3),
                        ),
                        child: Slider(
                          value: _tempRadius,
                          min: 0.5,
                          max: 20.0,
                          divisions: 39,
                          onChanged: (value) {
                            setState(() {
                              _tempRadius = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Preset buttons
                      Text(
                        'Quick Select',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _presetRadii.map((radius) {
                          final isSelected = _tempRadius == radius;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _tempRadius = radius;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.lightPrimary
                                    : AppColors.lightPrimary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${radius.toStringAsFixed(1)} km',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.lightPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 100), // Extra space for scrolling
                    ],
                  ),
                ),
              ),
              // Apply button
              Container(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onRadiusChanged(_tempRadius);
                      widget.onFilterApplied();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.4),
                      ),
                    ),
                    child: const Text('Apply Filter'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Radius',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '${widget.currentRadius.toStringAsFixed(1)} km',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightPrimary,
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: _showFilterBottomSheet,
            icon: const Icon(Icons.tune, size: 20),
            label: const Text('Filter'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightPrimary.withOpacity(0.1),
              foregroundColor: AppColors.lightPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
