import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexlock_app_v2/features/auth/domain/data/providers/auth_notifier.dart';
import 'package:nexlock_app_v2/features/auth/presentation/screens/login_screen.dart';
import 'package:nexlock_app_v2/features/auth/presentation/screens/register_screen.dart';
import 'package:nexlock_app_v2/features/home/presentation/screens/home_screen.dart';
import 'package:nexlock_app_v2/features/splash/presentation/screens/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  return GoRouter(
    redirect: (context, state) {
      return authState.when(
        data: (auth) {
          final isLoggedIn = auth.isAuthenticated;
          final isGoingToLogin = state.matchedLocation == '/login';
          final isGoingToRegister = state.matchedLocation == '/register';
          final isGoingToAuth = isGoingToLogin || isGoingToRegister;
          final isGoingToSplash = state.matchedLocation == '/';

          // If not logged in and not going to auth screens or splash, redirect to login
          if (!isLoggedIn && !isGoingToAuth && !isGoingToSplash) {
            return '/login';
          }

          // If logged in and going to auth screens or splash, redirect to home
          if (isLoggedIn && (isGoingToAuth || isGoingToSplash)) {
            return '/home';
          }

          return null;
        },
        loading: () => null,
        error: (_, __) => '/login',
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
    ],
  );
});
