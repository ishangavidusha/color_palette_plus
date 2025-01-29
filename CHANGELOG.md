# Changelog

All notable changes to this project will be documented in this file.

## 2.0.0

Major update introducing theme generation capabilities and Material 3 support.

### Added
- New `ThemeGenerator` class for automatic theme generation
- Support for Material 3 color roles system
- `ColorSchemeConfig` for customizing theme generation
- `ThemeConfig` for advanced theme customization
- Light and dark theme generation with `ThemePair`
- Comprehensive color role overrides system
- Support for different color harmony types in theme generation

### Changed
- Updated color handling to align with Material 3 specifications
- Improved color transformation algorithms
- Enhanced shade generation for better contrast ratios
- Optimize color generation methods using HSL adjustments for better contrast and lightness

### Breaking Changes
- Changed theme generation API to use new configuration classes
- Updated color role system to match Material 3 specifications

## 1.0.0

Initial release of the Color Palette library.

### Added
- `ColorPalette` class with Material Design swatch generation
- `ColorPalettes` class for generating color harmonies (monochromatic, analogous, complementary)
- Modern color component handling (using Flutter's new color APIs)
- Type-safe and null-safe implementation
- Comprehensive documentation with examples