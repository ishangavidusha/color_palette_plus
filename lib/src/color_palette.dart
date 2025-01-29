import 'package:flutter/material.dart';

/// A utility class for generating color palettes and managing color transformations.
///
/// Provides methods for creating Material Design color swatches, getting specific shades,
/// and managing color variations. This class implements color generation following
/// Material Design guidelines.
class ColorPalette {
  /// Creates a [MaterialColor] swatch from a base color.
  ///
  /// Generates a complete material design color swatch containing 10 shades
  /// ranging from lightest (50) to darkest (900). The provided [baseColor]
  /// becomes the 500 shade in the resulting swatch.
  ///
  /// Example:
  /// ```dart
  /// final Color blue = Color(0xFF2196F3);
  /// final MaterialColor blueSwatch = ColorPalette.generateSwatch(blue);
  /// ```
  ///
  /// [baseColor] is the color to use as the 500 shade.
  /// Returns a [MaterialColor] containing all shades from 50 to 900.
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

    final colorValue = (((baseColor.a * 255).round() & 0xff) << 24) | 
                      (((baseColor.r * 255).round() & 0xff) << 16) | 
                      (((baseColor.g * 255).round() & 0xff) << 8) | 
                      ((baseColor.b * 255).round() & 0xff);

    return MaterialColor(
      colorValue,
      _generateShadeMap(baseColor, white, darkBase),
    );
  }

  /// Generates a specific shade from a base color.
  ///
  /// Creates a single color variation based on the provided shade index.
  /// The shade index must be one of the standard Material Design shade values.
  ///
  /// Example:
  /// ```dart
  /// final Color baseBlue = Color(0xFF2196F3);
  /// final Color lightBlue = ColorPalette.getShade(baseBlue, 200); // Lighter shade
  /// final Color darkBlue = ColorPalette.getShade(baseBlue, 700);  // Darker shade
  /// ```
  ///
  /// [baseColor] is the color to generate the shade from.
  /// [shadeIndex] must be one of: 50, 100, 200, 300, 400, 500, 600, 700, 800, 900.
  /// Returns the generated [Color] for the specified shade.
  /// Throws [ArgumentError] if [shadeIndex] is invalid.
  static Color getShade(Color baseColor, int shadeIndex) {
    if (!_validShadeIndices.contains(shadeIndex)) {
      throw ArgumentError('Invalid shade index. Must be one of: $_validShadeIndices');
    }
    return generateSwatch(baseColor)[shadeIndex]!;
  }

  /// Generates all shades for a given color.
  ///
  /// Creates a complete map of all standard Material Design shades
  /// for the provided base color. This is useful when you need access
  /// to the full range of shades for custom color management.
  ///
  /// Example:
  /// ```dart
  /// final Color baseColor = Color(0xFF2196F3);
  /// final Map<int, Color> allShades = ColorPalette.getAllShades(baseColor);
  /// final Color shade50 = allShades[50]!;   // Lightest shade
  /// final Color shade900 = allShades[900]!;  // Darkest shade
  /// ```
  ///
  /// [baseColor] is the color to generate shades from.
  /// Returns an unmodifiable [Map] with shade indices as keys and [Color] objects as values.
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

  // A set of valid shade indices for Material Design colors
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

  /// Generates a map of color shades based on the provided base colors.
  ///
  /// This internal method creates the shade variations using HSL color space
  /// for more natural color transitions.
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

  /// Adjusts the lightness of an HSL color while maintaining its hue and saturation.
  ///
  /// [lightness] should be between 0.0 and 1.0.
  static Color _adjustLightness(HSLColor hslColor, double lightness) {
    return hslColor.withLightness(lightness.clamp(0.0, 1.0)).toColor();
  }
}

/// A class that provides methods for generating different types of color harmonies.
///
/// This class contains static methods for creating various color relationships
/// including monochromatic, analogous, and complementary color schemes.
class ColorPalettes {
  /// Creates a monochromatic palette from a base color.
  ///
  /// Generates a series of colors that share the same hue but have different
  /// lightness values, creating a cohesive, single-color palette.
  ///
  /// Example:
  /// ```dart
  /// final Color baseColor = Color(0xFF2196F3);
  /// final List<Color> monoColors = ColorPalettes.monochromatic(
  ///   baseColor,
  ///   steps: 5,
  /// );
  /// ```
  ///
  /// [baseColor] is the color to base the palette on.
  /// [steps] determines how many colors to generate (minimum 2).
  /// Returns a list of colors with varying brightness levels.
  /// Throws [ArgumentError] if steps is less than 2.
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
  /// Generates colors that are adjacent to the base color on the color wheel,
  /// creating a harmonious and related color scheme.
  ///
  /// Example:
  /// ```dart
  /// final Color baseColor = Color(0xFF2196F3);
  /// final List<Color> analogousColors = ColorPalettes.analogous(
  ///   baseColor,
  ///   steps: 3,
  ///   angle: 30,
  /// );
  /// ```
  ///
  /// [baseColor] is the color to base the palette on.
  /// [steps] determines how many colors to generate (minimum 1).
  /// [angle] is the angle between each color on the color wheel (in degrees).
  /// Returns a list of colors with similar hues.
  /// Throws [ArgumentError] if steps is less than 1.
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

  /// Creates a complementary color palette.
  ///
  /// Generates a two-color palette consisting of the base color and its complement
  /// (the color opposite on the color wheel), with adjusted lightness for better contrast.
  ///
  /// Example:
  /// ```dart
  /// final Color baseColor = Color(0xFF2196F3);
  /// final List<Color> complementaryColors = ColorPalettes.complementary(baseColor);
  /// // Returns [baseColor, complementColor]
  /// ```
  ///
  /// [baseColor] is the color to generate the complement for.
  /// Returns a list containing the base color and its complement.
  static List<Color> complementary(Color baseColor) {
    final hslColor = HSLColor.fromColor(baseColor);

    // Adjust complement lightness for better contrast
    final complementLightness = hslColor.lightness > 0.5 
        ? hslColor.lightness * 0.8 
        : hslColor.lightness * 1.2;

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