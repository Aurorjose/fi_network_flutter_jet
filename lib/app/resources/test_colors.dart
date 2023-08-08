import 'package:flutter/material.dart';

/// This class was created to simplify the technical test project.
/// In case this was a real project, we would use a more complex solution.
class TestColors {
  /// Default constructor.
  const TestColors();

  static const Color primary = Color(0xFF5F09FE);

  static const Color secondary = Color(0xFFF6F4FB);

  static const Color basePrimary = Color(0xFF000000);

  static Color get baseSecondary => basePrimary.withOpacity(0.7);

  static Color get baseAccent => primary;

  static Color get baseAccentSecondary => primary.withOpacity(0.7);
}
