import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is a placeholder for the home screen content.
    // You can replace it with your actual home screen implementation.
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(child: const Text('Welcome to the Home Screen!')),
    );
  }
}
