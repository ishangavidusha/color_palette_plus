import 'package:flutter/material.dart';
import 'color_palette.dart';

/// Configuration class for customizing theme generation in Material 3 applications.
///
/// Provides a structured way to configure theme generation with options for
/// brightness, color overrides, and color scheme configuration. This class
/// enables fine-grained control over the generated theme while maintaining
/// Material Design guidelines.
///
/// Example:
/// ```dart
/// final config = ThemeConfig(
///   brightness: Brightness.light,
///   colorOverrides: {
///     ColorRole.primary: Colors.blue,
///     ColorRole.secondary: Colors.green,
///   },
///   colorSchemeConfig: ColorSchemeConfig(
///     harmonyType: HarmonyType.analogous,
///   ),
/// );
///
/// final theme = ThemeGenerator.generateTheme(baseColor, config: config);
/// ```
class ThemeConfig {
  /// The target brightness for the theme.
  ///
  /// Determines whether the theme is generated for light mode ([Brightness.light])
  /// or dark mode ([Brightness.dark]). This affects various color calculations
  /// and contrast ratios throughout the theme.
  final Brightness brightness;

  /// Custom color mappings that override the default theme colors.
  ///
  /// A map where keys are [ColorRole] values representing different semantic
  /// color roles in the theme, and values are the [Color]s to use for those
  /// roles. Any color role not specified in this map will use the default
  /// generated color.
  ///
  /// See [ColorRole] for available color roles that can be overridden.
  final Map<ColorRole, Color>? colorOverrides;

  /// Configuration for generating the color scheme.
  ///
  /// Controls how secondary and tertiary colors are generated from the primary
  /// color using different harmony types and settings. If null, default
  /// configuration values will be used.
  ///
  /// See [ColorSchemeConfig] for available configuration options.
  final ColorSchemeConfig? colorSchemeConfig;

  /// Creates a configuration for theme generation.
  ///
  /// The [brightness] parameter defaults to [Brightness.light] if not specified.
  /// [colorOverrides] and [colorSchemeConfig] are optional and will use default
  /// values if not provided.
  const ThemeConfig({
    this.brightness = Brightness.light,
    this.colorOverrides,
    this.colorSchemeConfig,
  });

  /// Creates a copy of this configuration with dark brightness.
  ///
  /// This is useful when you want to create a matching dark theme configuration
  /// while preserving all other settings from the light theme configuration.
  ///
  /// Returns a new [ThemeConfig] instance with [Brightness.dark] and all other
  /// properties copied from this instance.
  ThemeConfig copyWithDark() {
    return ThemeConfig(
      brightness: Brightness.dark,
      colorOverrides: colorOverrides,
      colorSchemeConfig: colorSchemeConfig,
    );
  }
}

/// Configuration for generating color schemes in Material 3 themes.
///
/// This class provides options for controlling how secondary and tertiary colors
/// are generated from the primary color using different color harmony approaches.
///
/// Example:
/// ```dart
/// final config = ColorSchemeConfig(
///   harmonyType: HarmonyType.analogous,
///   analogousAngle: 30,
///   harmonySteps: 3,
/// );
/// ```
class ColorSchemeConfig {
  /// The type of color harmony to use for generating secondary and tertiary colors.
  ///
  /// Determines how additional colors are generated from the primary color:
  /// - [HarmonyType.analogous]: Creates colors adjacent on the color wheel
  /// - [HarmonyType.complementary]: Uses opposite colors on the color wheel
  /// - [HarmonyType.monochromatic]: Uses variations of the same hue
  final HarmonyType harmonyType;

  /// The angle between analogous colors in degrees.
  ///
  /// Only used when [harmonyType] is [HarmonyType.analogous]. This value
  /// determines how far apart the generated colors are on the color wheel.
  /// Smaller angles create more similar colors, while larger angles create
  /// more distinct colors.
  ///
  /// The default value is 30 degrees.
  final double analogousAngle;

  /// Number of steps for generating harmonious colors.
  ///
  /// Controls how many colors are generated when using [HarmonyType.analogous]
  /// or [HarmonyType.monochromatic]. For analogous harmonies, this determines
  /// the number of adjacent colors. For monochromatic harmonies, this determines
  /// the number of lightness variations.
  ///
  /// The default value is 3 steps.
  final int harmonySteps;

  /// Creates a configuration for color scheme generation.
  ///
  /// All parameters have default values that follow Material Design guidelines:
  /// - [harmonyType] defaults to [HarmonyType.analogous]
  /// - [analogousAngle] defaults to 30 degrees
  /// - [harmonySteps] defaults to 3 steps
  const ColorSchemeConfig({
    this.harmonyType = HarmonyType.analogous,
    this.analogousAngle = 30,
    this.harmonySteps = 3,
  });
}

/// The type of color harmony to use when generating a color scheme.
///
/// Each harmony type represents a different approach to creating a cohesive
/// color palette based on color theory principles.
enum HarmonyType {
  /// Creates colors that are adjacent on the color wheel.
  ///
  /// Analogous colors create a harmonious and unified look while maintaining
  /// enough contrast to distinguish different elements. This is often used
  /// for creating a cohesive, professional appearance.
  analogous,

  /// Uses colors from opposite sides of the color wheel.
  ///
  /// Complementary colors create strong contrast and visual interest. This
  /// is useful for creating emphasis or drawing attention to specific elements
  /// in the interface.
  complementary,

  /// Uses variations of the same color with different lightness values.
  ///
  /// Monochromatic schemes create a subtle, sophisticated look using a single
  /// hue. This is useful for creating a unified appearance while maintaining
  /// sufficient contrast for different interface elements.
  monochromatic,
}

/// Semantic color roles that can be customized in Material 3 themes.
///
/// These roles follow the Material 3 color system specifications and provide
/// semantic meaning to colors used throughout the application. Each role
/// represents a specific use case or context where a color should be applied.
enum ColorRole {
  // Core colors
  /// The primary color of the theme, used for key components and emphasis.
  primary,

  /// Color used for content appearing on [primary] surfaces.
  onPrimary,

  /// A tonal variation of [primary] used for containers and backgrounds.
  primaryContainer,

  /// Color used for content appearing on [primaryContainer] surfaces.
  onPrimaryContainer,

  /// The secondary color of the theme, used for less prominent components.
  secondary,

  /// Color used for content appearing on [secondary] surfaces.
  onSecondary,

  /// A tonal variation of [secondary] used for containers and backgrounds.
  secondaryContainer,

  /// Color used for content appearing on [secondaryContainer] surfaces.
  onSecondaryContainer,

  /// The tertiary color of the theme, used for contrasting accents.
  tertiary,

  /// Color used for content appearing on [tertiary] surfaces.
  onTertiary,

  /// A tonal variation of [tertiary] used for containers and backgrounds.
  tertiaryContainer,

  /// Color used for content appearing on [tertiaryContainer] surfaces.
  onTertiaryContainer,

  // Error colors
  /// Color used to indicate errors or destructive actions.
  error,

  /// Color used for content appearing on [error] surfaces.
  onError,

  /// A tonal variation of [error] used for error containers and backgrounds.
  errorContainer,

  /// Color used for content appearing on [errorContainer] surfaces.
  onErrorContainer,

  // Neutral colors
  /// The background color of the application.
  background,

  /// Color used for content appearing on [background] surfaces.
  onBackground,

  /// The primary surface color for components.
  surface,

  /// Color used for content appearing on [surface] surfaces.
  onSurface,

  /// A brighter variation of [surface].
  surfaceBright,

  /// A dimmer variation of [surface].
  surfaceDim,

  /// The lowest elevation surface container color.
  surfaceContainerLowest,

  /// A low elevation surface container color.
  surfaceContainerLow,

  /// The standard surface container color.
  surfaceContainer,

  /// A high elevation surface container color.
  surfaceContainerHigh,

  /// The highest elevation surface container color.
  surfaceContainerHighest,

  // Neutral variant colors
  /// A variation of [surface] used for subtle differentiation.
  surfaceVariant,

  /// Color used for content appearing on [surfaceVariant] surfaces.
  onSurfaceVariant,

  /// Color used for borders and dividers.
  outline,

  /// A variation of [outline] used for decorative elements.
  outlineVariant,

  // Inverse colors
  /// The inverse of the [surface] color.
  inverseSurface,

  /// Color used for content appearing on [inverseSurface].
  onInverseSurface,

  /// The inverse of the [primary] color.
  inversePrimary,

  // Shadow
  /// Color used for shadows.
  shadow,

  /// Color used for scrim overlays.
  scrim,

  // State layers
  /// Fixed version of the [primary] color.
  primaryFixed,

  /// Dimmed version of [primaryFixed].
  primaryFixedDim,

  /// Color used for content appearing on [primaryFixed].
  onPrimaryFixed,

  /// Variant color for content appearing on [primaryFixed].
  onPrimaryFixedVariant,

  /// Fixed version of the [secondary] color.
  secondaryFixed,

  /// Dimmed version of [secondaryFixed].
  secondaryFixedDim,

  /// Color used for content appearing on [secondaryFixed].
  onSecondaryFixed,

  /// Variant color for content appearing on [secondaryFixed].
  onSecondaryFixedVariant,

  /// Fixed version of the [tertiary] color.
  tertiaryFixed,

  /// Dimmed version of [tertiaryFixed].
  tertiaryFixedDim,

  /// Color used for content appearing on [tertiaryFixed].
  onTertiaryFixed,

  /// Variant color for content appearing on [tertiaryFixed].
  onTertiaryFixedVariant,
}

/// Extension methods for generating themes based on Material 3 specifications.
///
/// Provides utilities for generating complete [ThemeData] objects from a primary
/// color, with support for both light and dark themes. The generated themes
/// follow Material 3 design guidelines for color usage and contrast.
extension ThemeGenerator on ColorPalette {
  /// Generates a complete theme based on a primary color.
  static ThemeData generateTheme(
    Color primaryColor, {
    ThemeConfig? config,
  }) {
    final effectiveConfig = config ?? const ThemeConfig();
    final colorScheme = _generateColorScheme(primaryColor, effectiveConfig);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: effectiveConfig.brightness,
    );
  }

  /// Generates both light and dark themes based on a primary color.
  static ThemePair generateThemePair(
    Color primaryColor, {
    ThemeConfig? config,
  }) {
    final lightConfig = config ?? const ThemeConfig();
    final darkConfig = lightConfig.copyWithDark();

    return ThemePair(
      light: generateTheme(primaryColor, config: lightConfig),
      dark: generateTheme(primaryColor, config: darkConfig),
    );
  }

  static ColorScheme _generateColorScheme(Color primaryColor, ThemeConfig config) {
    final MaterialColor swatch = ColorPalette.generateSwatch(primaryColor);
    final harmonyConfig = config.colorSchemeConfig ?? const ColorSchemeConfig();

    // Use swatch for primary color variants
    final primaryContainer = swatch[700]!;
    final onPrimaryContainer = _generateOnColor(primaryContainer);

    // Generate secondary and tertiary colors based on harmony type
    final List<Color> harmonicColors = _generateHarmonicColors(
      primaryColor,
      harmonyConfig,
    );

    final Color secondaryColor = harmonicColors[1];
    final Color tertiaryColor = harmonicColors.length > 2 ? harmonicColors[2] : secondaryColor;

    // Apply any color overrides
    final colorOverrides = config.colorOverrides ?? {};

    // Generate surface colors
    final surfaceColor = _generateSurfaceColor(primaryColor, harmonicColors, config.brightness);

    // Generate default colors
    final defaultPrimary = swatch[500]!;
    final defaultError = _generateErrorColor(config.brightness);
    final defaultSurface = surfaceColor;

    return ColorScheme(
      brightness: config.brightness,
      // Primary colors
      primary: colorOverrides[ColorRole.primary] ?? defaultPrimary,
      onPrimary: colorOverrides[ColorRole.onPrimary] ?? _generateOnColor(defaultPrimary),
      primaryContainer: colorOverrides[ColorRole.primaryContainer] ?? primaryContainer,
      onPrimaryContainer: colorOverrides[ColorRole.onPrimaryContainer] ?? onPrimaryContainer,

      // Secondary colors
      secondary: colorOverrides[ColorRole.secondary] ?? secondaryColor,
      onSecondary: colorOverrides[ColorRole.onSecondary] ?? _generateOnColor(secondaryColor),
      secondaryContainer: colorOverrides[ColorRole.secondaryContainer] ?? ColorPalette.generateSwatch(secondaryColor)[700],
      onSecondaryContainer: colorOverrides[ColorRole.onSecondaryContainer] ?? _generateOnColor(ColorPalette.generateSwatch(secondaryColor)[700]!),

      // Tertiary colors
      tertiary: colorOverrides[ColorRole.tertiary] ?? tertiaryColor,
      onTertiary: colorOverrides[ColorRole.onTertiary] ?? _generateOnColor(tertiaryColor),
      tertiaryContainer: colorOverrides[ColorRole.tertiaryContainer] ?? ColorPalette.generateSwatch(tertiaryColor)[700],
      onTertiaryContainer: colorOverrides[ColorRole.onTertiaryContainer] ?? _generateOnColor(ColorPalette.generateSwatch(tertiaryColor)[700]!),

      // Error colors
      error: colorOverrides[ColorRole.error] ?? defaultError,
      onError: colorOverrides[ColorRole.onError] ?? _generateOnColor(defaultError),
      errorContainer: colorOverrides[ColorRole.errorContainer] ?? ColorPalette.generateSwatch(defaultError)[700],
      onErrorContainer: colorOverrides[ColorRole.onErrorContainer] ?? _generateOnColor(ColorPalette.generateSwatch(defaultError)[700]!),

      // Surface colors
      surface: colorOverrides[ColorRole.surface] ?? defaultSurface,
      onSurface: colorOverrides[ColorRole.onSurface] ?? _generateOnColor(defaultSurface),
      surfaceContainer: colorOverrides[ColorRole.surfaceContainer] ?? _adjustSurfaceContainer(defaultSurface, config.brightness),
      surfaceContainerHigh: colorOverrides[ColorRole.surfaceContainerHigh] ?? ColorPalette.generateSwatch(defaultSurface)[700],
      surfaceContainerHighest: colorOverrides[ColorRole.surfaceContainerHighest] ?? ColorPalette.generateSwatch(defaultSurface)[800],
      surfaceContainerLow: colorOverrides[ColorRole.surfaceContainerLow] ?? ColorPalette.generateSwatch(defaultSurface)[300],
      surfaceContainerLowest: colorOverrides[ColorRole.surfaceContainerLowest] ?? ColorPalette.generateSwatch(defaultSurface)[200],
      onSurfaceVariant: colorOverrides[ColorRole.onSurfaceVariant] ?? _generateOnColor(ColorPalette.generateSwatch(defaultSurface)[200]!),

      // Additional colors
      outline: colorOverrides[ColorRole.outline] ?? ColorPalette.generateSwatch(defaultSurface)[400],
      outlineVariant: colorOverrides[ColorRole.outlineVariant] ?? ColorPalette.generateSwatch(defaultSurface)[200],
      shadow: colorOverrides[ColorRole.shadow] ?? Colors.black,
      scrim: colorOverrides[ColorRole.scrim] ?? Colors.black,

      // Inverse colors
      inverseSurface: colorOverrides[ColorRole.inverseSurface] ?? Color.alphaBlend(defaultPrimary.withValues(alpha: 0.05), config.brightness == Brightness.light ? Colors.black : Colors.white),
      onInverseSurface: colorOverrides[ColorRole.onInverseSurface] ?? _generateOnColor(config.brightness == Brightness.light ? Colors.black : Colors.white),
      inversePrimary: colorOverrides[ColorRole.inversePrimary] ?? ColorPalette.generateSwatch(defaultPrimary)[200],
    );
  }

  /// Generates an appropriate surface color based on primary color and brightness.
  static Color _generateSurfaceColor(Color primaryColor, List<Color> harmonicColors, Brightness brightness) {
    final primaryHsl = HSLColor.fromColor(primaryColor);
    final primaryLightness = primaryHsl.lightness;

    // Use primary color lightness to determine surface color
    if (primaryLightness < 0.2) {
      return harmonicColors[1];
    } else if (primaryLightness > 0.8) {
      return harmonicColors[2];
    } else {
      return brightness == Brightness.light ? Colors.white : Colors.black;
    }
  }

  static Color _adjustSurfaceContainer(Color surface, Brightness brightness) {
    // For pure black or white, we should maintain neutral gray values
    if (surface == Colors.black || surface == Colors.white) {
      final grayValue = brightness == Brightness.light
          ? 0.95 // Slightly darker than white for light mode
          : 0.07; // Slightly lighter than black for dark mode
      return Color.fromRGBO(
        (grayValue * 255).round(),
        (grayValue * 255).round(),
        (grayValue * 255).round(),
        1.0,
      );
    }

    final surfaceHsl = HSLColor.fromColor(surface);
    final adjustedLightness = brightness == Brightness.light ? (surfaceHsl.lightness - 0.05).clamp(0.0, 1.0) : (surfaceHsl.lightness + 0.05).clamp(0.0, 1.0);

    return surfaceHsl.withLightness(adjustedLightness).toColor();
  }

  /// Generates harmonic colors based on the configuration.
  static List<Color> _generateHarmonicColors(
    Color primaryColor,
    ColorSchemeConfig config,
  ) {
    switch (config.harmonyType) {
      case HarmonyType.analogous:
        return ColorPalettes.analogous(
          primaryColor,
          steps: config.harmonySteps,
          angle: config.analogousAngle,
        );
      case HarmonyType.complementary:
        return ColorPalettes.complementary(primaryColor);
      case HarmonyType.monochromatic:
        return ColorPalettes.monochromatic(
          primaryColor,
          steps: config.harmonySteps,
        );
    }
  }

  /// Generates an appropriate contrasting color for text/icons on a background.
  static Color _generateOnColor(Color background) {
    final luminance = background.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Generates an appropriate error color based on brightness.
  static Color _generateErrorColor(Brightness brightness) {
    return brightness == Brightness.light
        ? const Color(0xFFB00020) // Material Design error color
        : const Color(0xFFCF6679); // Dark theme error color
  }
}

/// A container for paired light and dark themes.
///
/// This class provides a convenient way to manage both light and dark theme
/// variations generated from the same base configuration. This is particularly
/// useful when implementing dynamic theme switching in applications.
///
/// Example:
/// ```dart
/// final themePair = ThemeGenerator.generateThemePair(primaryColor);
/// MaterialApp(
///   theme: themePair.light,
///   darkTheme: themePair.dark,
///   themeMode: ThemeMode.system,
/// );
/// ```
class ThemePair {
  /// The light theme variant.
  final ThemeData light;

  /// The dark theme variant.
  final ThemeData dark;

  /// Creates a pair of light and dark themes.
  ///
  /// Both [light] and [dark] parameters are required and should be properly
  /// configured [ThemeData] instances for their respective brightness modes.
  const ThemePair({
    required this.light,
    required this.dark,
  });
}
