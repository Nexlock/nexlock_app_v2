import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/providers/auth_notifier.dart';
import 'package:nexlock_app_v2/features/auth/presentation/screens/login_screen.dart';
import 'package:nexlock_app_v2/features/auth/presentation/screens/register_screen.dart';
import 'package:nexlock_app_v2/features/home/presentation/screens/home_screen.dart';
import 'package:nexlock_app_v2/features/splash/presentation/screens/splash_screen.dart';
import 'package:nexlock_app_v2/features/auth/presentation/screens/profile_screen.dart';
import 'package:nexlock_app_v2/features/rental/presentation/screens/locker_screen.dart';
import 'package:nexlock_app_v2/features/module_list/presentation/screens/module_list_screen.dart';
import 'package:nexlock_app_v2/features/module/presentation/screens/module_screen.dart';
import 'package:nexlock_app_v2/features/home/presentation/screens/rental_history_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      return authState.when(
        data: (auth) {
          final isLoggedIn = auth.isAuthenticated == true;
          final currentPath = state.matchedLocation;

          // Don't redirect if there's an authentication error
          if (auth.error != null && auth.error!.isNotEmpty) {
            return null;
          }

          // Only redirect from splash screen when authenticated
          if (isLoggedIn && currentPath == '/') {
            return '/home';
          }

          // Redirect to login if trying to access protected routes while not authenticated
          if (!isLoggedIn &&
              currentPath != '/' &&
              currentPath != '/login' &&
              currentPath != '/register') {
            return '/login';
          }

          return null;
        },
        loading: () => null,
        error: (_, __) => null, // Don't redirect on error
      );
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const ModuleListScreen(),
      ),
      GoRoute(
        path: '/locker/:lockerId',
        builder: (context, state) {
          final lockerId = state.pathParameters['lockerId']!;
          return LockerScreen(lockerId: lockerId);
        },
      ),
      GoRoute(
        path: '/module/:moduleId',
        builder: (context, state) {
          final moduleId = state.pathParameters['moduleId']!;
          return ModuleScreen(moduleId: moduleId);
        },
      ),
      GoRoute(
        path: '/rental-history',
        builder: (context, state) => const RentalHistoryScreen(),
      ),
    ],
  );
});
