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
    final darkBase = _multiplyColors(baseColor, baseColor);

    // Create color value using color components
    final colorValue = (((baseColor.a * 255).round() & 0xff) << 24) |
                      ((baseColor.r * 255).round() & 0xff << 16) |
                      ((baseColor.g * 255).round() & 0xff << 8) |
                      ((baseColor.b * 255).round() & 0xff);

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
  static const _validShadeIndices = {50, 100, 200, 300, 400, 500, 600, 700, 800, 900};

  static Map<int, Color> _generateShadeMap(Color baseColor, Color lightBase, Color darkBase) {
    return {
      50: _blendColors(lightBase, baseColor, 0.12),
      100: _blendColors(lightBase, baseColor, 0.30),
      200: _blendColors(lightBase, baseColor, 0.50),
      300: _blendColors(lightBase, baseColor, 0.70),
      400: _blendColors(lightBase, baseColor, 0.85),
      500: baseColor,
      600: _blendColors(darkBase, baseColor, 0.87),
      700: _blendColors(darkBase, baseColor, 0.70),
      800: _blendColors(darkBase, baseColor, 0.54),
      900: _blendColors(darkBase, baseColor, 0.25),
    };
  }

  static Color _blendColors(Color color1, Color color2, double amount) {
    final r = _interpolate(color1.r, color2.r, amount);
    final g = _interpolate(color1.g, color2.g, amount);
    final b = _interpolate(color1.b, color2.b, amount);
    final a = _interpolate(color1.a, color2.a, amount);

    return Color.fromRGBO(
      (r * 255).round(),
      (g * 255).round(),
      (b * 255).round(),
      a,
    );
  }

  static Color _multiplyColors(Color color1, Color color2) {
    return Color.fromRGBO(
      ((color1.r * color2.r) * 255).round(),
      ((color1.g * color2.g) * 255).round(),
      ((color1.b * color2.b) * 255).round(),
      color1.a,
    );
  }

  static double _interpolate(double value1, double value2, double amount) {
    return value1 + (value2 - value1) * amount;
  }
}

/// A class that holds predefined color palettes.
class ColorPalettes {
  /// Creates a monochromatic palette from a base color.
  /// 
  /// Returns a list of colors with varying brightness levels.
  static List<Color> monochromatic(Color baseColor, {int steps = 5}) {
    final hslColor = HSLColor.fromColor(baseColor);
    return List.generate(steps, (index) {
      final lightness = (1.0 / (steps - 1)) * index;
      return HSLColor.fromAHSL(
        baseColor.a,
        hslColor.hue,
        hslColor.saturation,
        lightness,
      ).toColor();
    });
  }

  /// Creates an analogous color palette from a base color.
  /// 
  /// Returns a list of colors with similar hues.
  static List<Color> analogous(Color baseColor, {int steps = 3, double angle = 30}) {
    final hslColor = HSLColor.fromColor(baseColor);
    return List.generate(steps, (index) {
      final hue = (hslColor.hue + (index - (steps - 1) / 2) * angle) % 360;
      return HSLColor.fromAHSL(
        baseColor.a,
        hue,
        hslColor.saturation,
        hslColor.lightness,
      ).toColor();
    });
  }

  /// Creates a complementary color palette.
  /// 
  /// Returns a list containing the base color and its complement.
  static List<Color> complementary(Color baseColor) {
    final hslColor = HSLColor.fromColor(baseColor);
    final complement = HSLColor.fromAHSL(
      baseColor.a,
      (hslColor.hue + 180) % 360,
      hslColor.saturation,
      hslColor.lightness,
    ).toColor();
    return [baseColor, complement];
  }
}