import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00B5CC)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
