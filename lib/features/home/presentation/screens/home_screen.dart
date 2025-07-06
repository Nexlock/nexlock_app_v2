import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexlock_app_v2/features/home/presentation/widgets/active_rentals.dart';
import 'package:nexlock_app_v2/features/home/presentation/widgets/profile_header.dart';
import 'package:nexlock_app_v2/features/home/presentation/widgets/quick_actions_tab.dart';
import 'package:nexlock_app_v2/features/home/presentation/widgets/search_module_card.dart';
import 'package:nexlock_app_v2/features/rental/domain/data/providers/rental_notifier.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch active rentals when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rentalProvider.notifier).fetchActiveRentals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
              const SizedBox(height: 24),
              const SearchModuleCard(),
              const SizedBox(height: 32),
              const QuickActionsTab(),
              const SizedBox(height: 32),
              const ActiveRentals(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
