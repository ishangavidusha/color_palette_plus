library;

import 'package:flutter/material.dart';

/// A utility class for generating color palettes and managing color transformations.
class ColorPalette {
  /// Creates a [MaterialColor] swatch from a base color.
  ///
  /// The swatch contains 10 shades of the base color, ranging from lighter (50)
  /// to darker (900) variations.
  static MaterialColor generateSwatch(Color baseColor) {
    const white = Color(0xFFFFFFFF);
    final hslBase = HSLColor.fromColor(baseColor);

    // Generate dark base using HSL lightness adjustments
    final darkBase = HSLColor.fromAHSL(
      baseColor.a,
      hslBase.hue,
      hslBase.saturation,
      (hslBase.lightness * 0.6).clamp(0.0, 1.0), // Reduce lightness by 40%
    ).toColor();

    final colorValue = (((baseColor.a * 255).round() & 0xff) << 24) | (((baseColor.r * 255).round() & 0xff) << 16) | (((baseColor.g * 255).round() & 0xff) << 8) | ((baseColor.b * 255).round() & 0xff);

    return MaterialColor(
      colorValue,
      _generateShadeMap(baseColor, white, darkBase),
    );
  }

  /// Generates a specific shade from a base color.
  ///
  /// [baseColor] is the color to generate the shade from.
  /// [shadeIndex] must be one of: 50, 100, 200, 300, 400, 500, 600, 700, 800, 900.
  /// Throws [ArgumentError] if [shadeIndex] is invalid.
  static Color getShade(Color baseColor, int shadeIndex) {
    if (!_validShadeIndices.contains(shadeIndex)) {
      throw ArgumentError('Invalid shade index. Must be one of: $_validShadeIndices');
    }
    return generateSwatch(baseColor)[shadeIndex]!;
  }

  /// Generates all shades for a given color.
  ///
  /// Returns a [Map] with shade indices as keys and [Color] objects as values.
  static Map<int, Color> getAllShades(Color baseColor) {
    final MaterialColor swatch = generateSwatch(baseColor);
    return Map.unmodifiable({
      50: swatch[50]!,
      100: swatch[100]!,
      200: swatch[200]!,
      300: swatch[300]!,
      400: swatch[400]!,
      500: swatch[500]!,
      600: swatch[600]!,
      700: swatch[700]!,
      800: swatch[800]!,
      900: swatch[900]!,
    });
  }

  // Private helper methods
  static const _validShadeIndices = {
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900
  };

  static Map<int, Color> _generateShadeMap(Color baseColor, Color lightBase, Color darkBase) {
    final hslBase = HSLColor.fromColor(baseColor);

    return {
      50: _adjustLightness(hslBase, 0.95),
      100: _adjustLightness(hslBase, 0.88),
      200: _adjustLightness(hslBase, 0.80),
      300: _adjustLightness(hslBase, 0.70),
      400: _adjustLightness(hslBase, 0.60),
      500: baseColor,
      600: _adjustLightness(hslBase, 0.40),
      700: _adjustLightness(hslBase, 0.30),
      800: _adjustLightness(hslBase, 0.20),
      900: _adjustLightness(hslBase, 0.12),
    };
  }

  static Color _adjustLightness(HSLColor hslColor, double lightness) {
    return hslColor.withLightness(lightness.clamp(0.0, 1.0)).toColor();
  }
}

/// A class that holds predefined color palettes.
class ColorPalettes {
  /// Creates a monochromatic palette from a base color using perceptually balanced lightness.
  ///
  /// [steps] must be at least 2.
  /// Returns a list of colors with varying brightness levels.
  static List<Color> monochromatic(Color baseColor, {int steps = 5}) {
    if (steps < 2) {
      throw ArgumentError('Steps must be at least 2');
    }

    final hslColor = HSLColor.fromColor(baseColor);
    return List.generate(steps, (index) {
      final t = index / (steps - 1);
      // Perceptual lightness curve (quadratic ease-in)
      final lightness = 0.15 + 0.7 * t * t;
      return HSLColor.fromAHSL(
        baseColor.a,
        hslColor.hue,
        hslColor.saturation,
        lightness.clamp(0.0, 1.0),
      ).toColor();
    });
  }

  /// Creates an analogous color palette from a base color.
  ///
  /// [steps] must be at least 1.
  /// [angle] should be between 0 and 360 degrees.
  /// Returns a list of colors with similar hues.
  static List<Color> analogous(
    Color baseColor, {
    int steps = 3,
    double angle = 30,
  }) {
    if (steps < 1) {
      throw ArgumentError('Steps must be at least 1');
    }

    final hslColor = HSLColor.fromColor(baseColor);
    return List.generate(steps, (index) {
      final hueOffset = (index - (steps - 1) / 2) * angle;
      final hue = (hslColor.hue + hueOffset) % 360;
      return HSLColor.fromAHSL(
        baseColor.a,
        hue,
        hslColor.saturation,
        hslColor.lightness,
      ).toColor();
    });
  }

  /// Creates a complementary color palette with adjusted lightness for better contrast.
  ///
  /// Returns a list containing the base color and its complement.
  static List<Color> complementary(Color baseColor) {
    final hslColor = HSLColor.fromColor(baseColor);

    // Adjust complement lightness for better contrast
    final complementLightness = hslColor.lightness > 0.5 ? hslColor.lightness * 0.8 : hslColor.lightness * 1.2;

    final complement = HSLColor.fromAHSL(
      baseColor.a,
      (hslColor.hue + 180) % 360,
      hslColor.saturation,
      complementLightness.clamp(0.0, 1.0),
    ).toColor();

    return [
      baseColor,
      complement
    ];
  }
}
