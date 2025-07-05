import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    redirect: (context, state) {},
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Text('Splash Screen'),
      ),
    ],
  );
});
