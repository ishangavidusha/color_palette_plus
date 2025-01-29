import 'package:flutter/material.dart';
import 'package:color_palette_plus/color_palette_plus.dart';

void main() {
  runApp(const ColorPaletteDemo());
}

class ColorPaletteDemo extends StatefulWidget {
  const ColorPaletteDemo({super.key});

  @override
  State<ColorPaletteDemo> createState() => _ColorPaletteDemoState();
}

class _ColorPaletteDemoState extends State<ColorPaletteDemo> {
  Color selectedColor = Colors.blue;
  HarmonyType selectedHarmony = HarmonyType.analogous;
  ThemeMode themeMode = ThemeMode.light;

  void updateColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void updateHarmony(HarmonyType harmony) {
    setState(() {
      selectedHarmony = harmony;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Palette Demo',
      theme: ThemeGenerator.generateTheme(
        selectedColor,
        config: ThemeConfig(
          colorSchemeConfig: ColorSchemeConfig(
            harmonyType: selectedHarmony,
            analogousAngle: 30,
            harmonySteps: 5,
          ),
        ),
      ),
      darkTheme: ThemeGenerator.generateTheme(
        selectedColor,
        config: ThemeConfig(
          brightness: Brightness.dark,
          colorSchemeConfig: ColorSchemeConfig(
            harmonyType: selectedHarmony,
            analogousAngle: 30,
            harmonySteps: 5,
          ),
        ),
      ),
      themeMode: themeMode,
      home: HomePage(
        selectedColor: selectedColor,
        selectedHarmony: selectedHarmony,
        onColorChanged: updateColor,
        onHarmonyChanged: updateHarmony,
        themeMode: themeMode,
        onThemeModeChanged: (ThemeMode mode) => setState(() => themeMode = mode),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Color selectedColor;
  final HarmonyType selectedHarmony;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<HarmonyType> onHarmonyChanged;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const HomePage({
    super.key,
    required this.selectedColor,
    required this.selectedHarmony,
    required this.onColorChanged,
    required this.onHarmonyChanged,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final materialSwatch = ColorPalette.generateSwatch(selectedColor);
    final monochromaticColors = ColorPalettes.monochromatic(selectedColor, steps: 10);
    final analogousColors = ColorPalettes.analogous(selectedColor, steps: 5, angle: 30);
    final complementaryColors = ColorPalettes.complementary(selectedColor);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Palette Demo'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        actions: [
          // Theme mode toggle button
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {
              onThemeModeChanged(
                themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
              );
            },
            tooltip: '${themeMode == ThemeMode.light ? "Dark" : "Light"} mode',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color Picker and Harmony Selection
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Base Color',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Colors.red,
                      Colors.pink,
                      Colors.purple,
                      Colors.deepPurple,
                      Colors.indigo,
                      Colors.blue,
                      Colors.lightBlue,
                      Colors.cyan,
                      Colors.teal,
                      Colors.green,
                      Colors.lightGreen,
                      Colors.lime,
                      Colors.yellow,
                      Colors.amber,
                      Colors.orange,
                      Colors.deepOrange,
                      Colors.brown,
                      Colors.grey,
                      Colors.blueGrey,
                    ]
                        .map((color) => _ColorPickerItem(
                              color: color,
                              isSelected: selectedColor == color,
                              onTap: () => onColorChanged(color),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Harmony Type',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: HarmonyType.values
                        .map((type) => ChoiceChip(
                              label: Text(
                                type.name,
                                style: TextStyle(
                                  color: selectedHarmony == type ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              selected: selectedHarmony == type,
                              onSelected: (selected) {
                                if (selected) {
                                  onHarmonyChanged(type);
                                }
                              },
                              selectedColor: Theme.of(context).colorScheme.primary,
                              backgroundColor: Theme.of(context).colorScheme.surface,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Theme Color Scheme
            _PaletteSection(
              title: 'Theme Color Scheme',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ColorTile(
                    color: Theme.of(context).colorScheme.primary,
                    label: 'Primary',
                  ),
                  _ColorTile(
                    color: Theme.of(context).colorScheme.secondary,
                    label: 'Secondary',
                  ),
                  _ColorTile(
                    color: Theme.of(context).colorScheme.tertiary,
                    label: 'Tertiary',
                  ),
                  _ColorTile(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    label: 'Primary Container',
                  ),
                  _ColorTile(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    label: 'Secondary Container',
                  ),
                  _ColorTile(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    label: 'Tertiary Container',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Material Swatch
            _PaletteSection(
              title: 'Material Swatch',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
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
                ]
                    .map((shade) => _ColorTile(
                          color: materialSwatch[shade]!,
                          label: '$shade',
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Monochromatic Palette
            _PaletteSection(
              title: 'Monochromatic Palette',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: monochromaticColors
                    .asMap()
                    .entries
                    .map((entry) => _ColorTile(
                          color: entry.value,
                          label: 'Shade ${entry.key + 1}',
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                // Analogous Palette
                Expanded(
                  child: _PaletteSection(
                    title: 'Analogous Palette',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: analogousColors
                          .asMap()
                          .entries
                          .map((entry) => _ColorTile(
                                color: entry.value,
                                label: 'Color ${entry.key + 1}',
                              ))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Complementary Colors
                Expanded(
                  child: _PaletteSection(
                    title: 'Complementary Colors',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _ColorTile(
                          color: complementaryColors[0],
                          label: 'Base',
                        ),
                        _ColorTile(
                          color: complementaryColors[1],
                          label: 'Complement',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PaletteSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _PaletteSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _ColorTile extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorTile({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final luminance = color.computeLuminance();
    final textColor = luminance > 0.5 ? Colors.black : Colors.white;
    const width = 100.0;
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _ColorPickerItem extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorPickerItem({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.onSurface : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
          ],
        ),
      ),
    );
  }
}
