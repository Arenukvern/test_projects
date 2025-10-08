import 'package:conference_app_2025/common_imports.dart';

/// Example screen demonstrating all UI Kit components
///
/// This file serves as a reference for using the UI Kit components.
/// It showcases:
/// - Theme switching (light/dark)
/// - Text scaling
/// - All atomic and molecular components
class UiKitExampleScreen extends StatefulWidget {
  const UiKitExampleScreen({super.key});

  @override
  State<UiKitExampleScreen> createState() => _UiKitExampleScreenState();
}

class _UiKitExampleScreenState extends State<UiKitExampleScreen> {
  final _searchController = TextEditingController();
  var _selectedChips = <String>{'Flutter'};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => UiScaffold(
    // Optional: override text scale for this screen
    // textScaleFactor: 1.2,
    appBar: AppBar(title: const UiText('UI Kit Example')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Theme colors example
        const UiText(
          'Theme Colors',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildColorRow(context),
        const SizedBox(height: 24),

        // Search bar
        const UiText(
          'Search Bar',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        UiSearchBar(
          controller: _searchController,
          hintText: 'Search speakers...',
          onChanged: (final text) => debugPrint('Search: $text'),
        ),
        const SizedBox(height: 24),

        // Buttons
        const UiText(
          'Buttons',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            UiButton(onPressed: () {}, child: const UiText('Filled')),
            UiButton(
              onPressed: () {},
              decoration: UiButtonDecoration.outlined,
              child: const UiText('Outlined'),
            ),
            UiButton(
              onPressed: () {},
              decoration: UiButtonDecoration.text,
              child: const UiText('Text'),
            ),
            UiButton(
              onPressed: () {},
              decoration: UiButtonDecoration.gradientStyle,
              icon: const Icon(Icons.star),
              child: const UiText('Gradient'),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Loading indicators
        const UiText(
          'Loading Indicators',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            UiLoadingIndicator(size: UiLoadingIndicatorSize.small),
            SizedBox(width: 16),
            UiLoadingIndicator(),
            SizedBox(width: 16),
            UiLoadingIndicator(size: UiLoadingIndicatorSize.large),
          ],
        ),
        const SizedBox(height: 24),

        // Multichips
        const UiText(
          'Chips',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        UiMultichipsRow(
          items: const ['Flutter', 'Dart', 'Firebase', 'Android', 'iOS'],
          selectedItems: _selectedChips,
          selectionMode: UiMultichipsSelectionMode.multiple,
          onSelectionChanged: (final selected) {
            setState(() => _selectedChips = selected);
          },
        ),
        const SizedBox(height: 24),

        // List tiles
        const UiText(
          'List Tiles',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        UiListTile(
          leading: const Icon(Icons.person),
          title: const UiText('John Doe'),
          subtitle: const UiText('Speaker'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => debugPrint('Tapped John Doe'),
        ),
        UiListTile(
          leading: const Icon(Icons.event),
          title: const UiText('Flutter Conference 2025'),
          subtitle: const UiText('May 15-17, 2025'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => debugPrint('Tapped conference'),
        ),
        const SizedBox(height: 24),

        // Text scale control
        const UiText(
          'Text Scale Control',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildTextScaleControls(context),
      ],
    ),
  );

  Widget _buildColorRow(final BuildContext context) {
    final appColors = context.appColors;
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _colorBox('Primary', colorScheme.primary),
        _colorBox('Secondary', colorScheme.secondary),
        _colorBox('Red', appColors.red),
        _colorBox('Yellow', appColors.yellow),
        _colorBox('Orange', appColors.orange),
      ],
    );
  }

  Widget _colorBox(final String label, final Color color) => Column(
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
      ),
      const SizedBox(height: 4),
      UiText(label, style: const TextStyle(fontSize: 12)),
    ],
  );

  Widget _buildTextScaleControls(final BuildContext context) {
    final resource = context.watch<TextScaleResource>();
    final currentScaler = resource.scalerOf(context);
    final isCustom = resource.value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiText(
          isCustom
              ? 'Custom scale: ${currentScaler.scale(1).toStringAsFixed(1)}x'
              : 'System scale (auto)',
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            UiButton(
              onPressed: resource.useSystemScale,
              decoration: UiButtonDecoration.outlined,
              text: 'System',
            ),
            UiButton(
              onPressed: () => resource.setScale(0.8),
              decoration: UiButtonDecoration.outlined,
              text: '0.8x',
            ),
            UiButton(
              onPressed: () => resource.setScale(1),
              decoration: UiButtonDecoration.outlined,
              text: '1.0x',
            ),
            UiButton(
              onPressed: () => resource.setScale(1.2),
              decoration: UiButtonDecoration.outlined,
              text: '1.2x',
            ),
            UiButton(
              onPressed: () => resource.setScale(1.5),
              decoration: UiButtonDecoration.outlined,
              text: '1.5x',
            ),
          ],
        ),
      ],
    );
  }
}
