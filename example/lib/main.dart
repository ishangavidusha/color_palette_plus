import 'package:flutter/material.dart';
import 'package:color_palette_plus/color_palette_plus.dart';

void main() {
  runApp(const ColorPaletteDemo());
}

class ColorPaletteDemo extends StatelessWidget {
  const ColorPaletteDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Palette Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final materialSwatch = ColorPalette.generateSwatch(selectedColor);
    final monochromaticColors = ColorPalettes.monochromatic(selectedColor);
    final analogousColors = ColorPalettes.analogous(selectedColor);
    final complementaryColors = ColorPalettes.complementary(selectedColor);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Palette Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color Picker
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: 0.5),
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
                              onTap: () => setState(() => selectedColor = color),
                            ))
                        .toList(),
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

            // Analogous Palette
            _PaletteSection(
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
            const SizedBox(height: 16),

            // Complementary Colors
            _PaletteSection(
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
        color: Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: 0.5),
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
    final width = MediaQuery.of(context).size.width / 3 - 32;
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
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
          ],
        ),
      ),
    );
  }
}
