import 'package:flutter/material.dart';

import 'test_colors.dart';

/// This class was created to simplify the technical test project.
/// In case this was a real project, we would use a more complex solution.
class TestTextStyles {
  /// Default constructor.
  const TestTextStyles();

  static TextStyle get appBar => const TextStyle(
        fontSize: 20.0,
        color: TestColors.secondary,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get mainTitle => const TextStyle(
        fontSize: 17.0,
        color: TestColors.primary,
      );

  static TextStyle get productTitleAccent => const TextStyle(
        fontSize: 17.0,
        color: TestColors.secondary,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get productDescriptionAccent => TextStyle(
        fontSize: 17.0,
        color: TestColors.secondary.withOpacity(0.7),
        fontWeight: FontWeight.w300,
      );
}
