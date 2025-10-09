# UI Kit

Comprehensive UI component library following atomic design principles with Material 3 theming, accessibility features, and responsive design.

## Features

### UI & Accessibility
- ✅ Adaptive design (supports different screen sizes)
- ✅ Light and dark theme support (Material 3)
- ✅ System font size support with configurable text scale ratio via `UiScaffold`

## Structure

```
ui_kit/
├── atoms/              # Basic UI elements
│   ├── ui_text.dart           # Adaptive text widget
│   ├── ui_loading_indicator.dart  # Loading spinners
│   └── ui_chip.dart           # Single chip component
├── molecules/          # Composite components
│   ├── ui_search_bar.dart     # Search with icon & clear button
│   ├── ui_button.dart         # Universal button with decoration pattern
│   ├── ui_list_tile.dart      # Styled list item
│   └── ui_multichips_row.dart # Scrollable chip row
├── decorations/        # Extension type decorations
│   └── ui_button_decoration.dart  # Button styling extension type
├── scaffolds/          # Layout components
│   └── ui_scaffold.dart       # Custom scaffold with text scaling
└── theme/              # Theme configuration
    ├── app_theme.dart         # Material 3 light/dark themes
    ├── app_colors.dart        # Color constants
    ├── app_text_style.dart    # Text styles
    └── app_fonts.dart         # Font definitions
```

## Quick Start

### 1. Setup in main.dart

```dart
void main() {
  Di.instance.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => DiProvider(
    builder: (context) => MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    ),
  );
}

// TextScaleResource is registered in DI and provided via DiProvider
```

### 2. Use UiScaffold in screens

```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => UiScaffold(
    // Optional: override global text scale for this screen
    textScaleFactor: 1.2,
    appBar: AppBar(title: UiText('My Screen')),
    body: MyContent(),
  );
}
```

### 3. Control text scale programmatically

```dart
// Access the resource
final textScaleResource = context.watch<TextScaleResource>();

// Set custom scale
textScaleResource.setScale(1.5);

// Use system scale (auto)
textScaleResource.useSystemScale();
```

## Components

### Atoms

#### UiText
Adaptive text respecting configured text scale.

```dart
UiText(
  'Hello World',
  style: AppTextStyle.s16.copyWith(fontWeight: FontWeight.bold),
)
```

#### UiLoadingIndicator
Material 3 loading spinner with size variants.

```dart
UiLoadingIndicator(size: UiLoadingIndicatorSize.medium)
```

#### UiChip
Single selectable chip.

```dart
UiChip(
  label: 'Flutter',
  selected: true,
  onSelected: (selected) => print(selected),
)
```

### Molecules

#### UiSearchBar
Search field with icon and clear button.

```dart
UiSearchBar(
  controller: _searchController,
  onChanged: (text) => _handleSearch(text),
  hintText: 'Search speakers...',
)
```

#### UiButton
Universal button with multiple decoration styles following extension type pattern.

```dart
// Filled button (default)
UiButton(
  onPressed: () {},
  text: 'Submit',
)

// Outlined button
UiButton(
  onPressed: () {},
  decoration: UiButtonDecoration.outlined,
  text: 'Cancel',
)

// Gradient button with icon
UiButton(
  onPressed: () {},
  decoration: UiButtonDecoration.gradientStyle,
  icon: Icon(Icons.star),
  text: 'Featured',
)

// Loading state
UiButton(
  text: 'Processing...',
  isLoading: true,
  onPressed: () {},
)

// Custom decoration
UiButton(
  decoration: UiButtonDecoration.create(
    backgroundColor: Colors.blue,
    padding: EdgeInsets.all(16),
  ),
  text: 'Custom',
  onPressed: () {},
)
```

#### UiListTile
Styled list item with leading/trailing widgets.

```dart
UiListTile(
  leading: Icon(Icons.person),
  title: UiText('John Doe'),
  subtitle: UiText('Speaker'),
  trailing: Icon(Icons.chevron_right),
  onTap: () => navigateToDetails(),
)
```

#### UiMultichipsRow
Scrollable row of chips with selection handling.

```dart
UiMultichipsRow(
  items: ['Flutter', 'Dart', 'Firebase'],
  selectedItems: _selectedTags,
  selectionMode: UiMultichipsSelectionMode.multiple,
  onSelectionChanged: (selected) {
    setState(() => _selectedTags = selected);
  },
)
```

## Theme Access

Access custom app colors via extension:

```dart
final appColors = context.appColors;
Container(
  color: appColors.red,
  // or gradient colors:
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        appColors.gradientYellow,
        appColors.gradientOrange,
        appColors.gradientRed,
      ],
    ),
  ),
)
```

## Text Scaling

### Global Scale
Control app-wide text scale via resource:

```dart
final textScaleResource = context.watch<TextScaleResource>();

// Set custom scale
textScaleResource.setScale(1.5);

// Use system scale (respects device accessibility settings)
textScaleResource.useSystemScale();
```

### Per-Screen Scale
Override for specific screens:

```dart
UiScaffold(
  textScaleFactor: 1.2,
  body: MyContent(),
)
```

### Architecture
- `TextScaleResource` is a `ValueNotifier<TextScaler?>` registered in DI
- When `null`, uses system scale from `MediaQuery`
- When set, applies custom scale factor
- Provided via `ChangeNotifierProvider` in `DiProvider`

## Example

See `ui_kit_example.dart` for a comprehensive demonstration of all components.

## Design Principles

1. **Atomic Design**: Components organized as atoms (basic) and molecules (composite)
2. **Material 3**: Uses latest Material Design guidelines
3. **Theme-Aware**: All components respect app theme (light/dark)
4. **Accessible**: Text scaling, semantic labels, proper contrast
5. **Responsive**: Adapts to different screen sizes
6. **Consistent**: Unified styling across the app
