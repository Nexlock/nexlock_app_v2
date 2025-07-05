import 'package:flutter/material.dart';

class AppColors {
  // Light theme colors (converted from CSS oklch values)
  static const Color lightBackground = Color(0xFFFEFEFE); // --background
  static const Color lightForeground = Color(0xFF000000); // --foreground
  static const Color lightCard = Color(0xFFFEFEFE); // --card
  static const Color lightCardForeground = Color(
    0xFF000000,
  ); // --card-foreground
  static const Color lightPrimary = Color(0xFF8B5CF6); // --primary (purple)
  static const Color lightPrimaryForeground = Color(
    0xFFFFFFFF,
  ); // --primary-foreground
  static const Color lightSecondary = Color(0xFFF1F5F9); // --secondary
  static const Color lightSecondaryForeground = Color(
    0xFF0F172A,
  ); // --secondary-foreground
  static const Color lightMuted = Color(0xFFF8FAFC); // --muted
  static const Color lightMutedForeground = Color(
    0xFF64748B,
  ); // --muted-foreground
  static const Color lightAccent = Color(0xFFF1F5F9); // --accent
  static const Color lightAccentForeground = Color(
    0xFF7C3AED,
  ); // --accent-foreground
  static const Color lightBorder = Color(0xFFE2E8F0); // --border
  static const Color lightInput = Color(0xFFF1F5F9); // --input
  static const Color lightDestructive = Color(0xFFEF4444); // --destructive
  static const Color lightDestructiveForegound = Color(
    0xFFFFFFFF,
  ); // --destructive-foreground

  // Dark theme colors (converted from CSS oklch values)
  static const Color darkBackground = Color(0xFF0F0F23); // --background
  static const Color darkForeground = Color(0xFFF1F5F9); // --foreground
  static const Color darkCard = Color(0xFF1E1E2E); // --card
  static const Color darkCardForeground = Color(
    0xFFF1F5F9,
  ); // --card-foreground
  static const Color darkPrimary = Color(0xFF8B5CF6); // --primary
  static const Color darkPrimaryForeground = Color(
    0xFFFFFFFF,
  ); // --primary-foreground
  static const Color darkSecondary = Color(0xFF27272A); // --secondary
  static const Color darkSecondaryForeground = Color(
    0xFFF1F5F9,
  ); // --secondary-foreground
  static const Color darkMuted = Color(0xFF27272A); // --muted
  static const Color darkMutedForeground = Color(
    0xFF71717A,
  ); // --muted-foreground
  static const Color darkAccent = Color(0xFF3F3F46); // --accent
  static const Color darkAccentForeground = Color(
    0xFFA855F7,
  ); // --accent-foreground
  static const Color darkBorder = Color(0xFF3F3F46); // --border
  static const Color darkInput = Color(0xFF3F3F46); // --input
  static const Color darkDestructive = Color(0xFFEF4444); // --destructive
  static const Color darkDestructiveForegound = Color(
    0xFFFFFFFF,
  ); // --destructive-foreground

  // Status colors (matching the dashboard UI)
  static const Color success = Color(
    0xFF22C55E,
  ); // Green for online/active status
  static const Color warning = Color(0xFFF59E0B); // Yellow for warnings
  static const Color error = Color(0xFFEF4444); // Red for offline/error status
  static const Color info = Color(0xFF3B82F6); // Blue for information

  // Gradient colors for the purple theme
  static const Color gradientStart = Color(0xFF8B5CF6);
  static const Color gradientEnd = Color(0xFF7C3AED);
}
