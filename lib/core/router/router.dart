import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/providers/auth_notifier.dart';
import 'package:nexlock_app_v2/features/auth/splash/presentation/screens/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  return GoRouter(
    redirect: (context, state) {
      return authState.when(
        data: (auth) {
          final isLoggedIn = auth.isAuthenticated;
          final isGoingToAuth = state.matchedLocation == '/auth';
          final isGoingToSplash = state.matchedLocation == '/';

          // If not logged in and not going to auth or splash, redirect to auth
          if (!isLoggedIn && !isGoingToAuth && !isGoingToSplash) {
            return '/auth';
          }

          // If logged in and going to auth or splash, redirect to home
          if (isLoggedIn && (isGoingToAuth || isGoingToSplash)) {
            return '/home';
          }

          return null;
        },
        loading: () => null,
        error: (_, __) => '/auth',
      );
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    ],
  );
});
