import 'package:conference_app_2025/common_imports.dart';

/// {@template ui_profile_screen}
/// Screen displaying user profile and application settings.
///
/// Features:
/// - Text scale adjustment (smaller/bigger/auto)
/// - Theme brightness toggle (light/dark/system)
/// {@endtemplate}
class UiProfileScreen extends StatelessWidget {
  /// {@macro ui_profile_screen}
  const UiProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile section placeholder
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Conference Attendee',
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Settings section
          Text(
            'Settings',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Text Scale settings
          const _TextScaleSettingCard(),
          const SizedBox(height: 16),

          // Theme Brightness settings
          const _ThemeBrightnessSettingCard(),
        ],
      ),
    );
  }
}

class _TextScaleSettingCard extends StatelessWidget {
  const _TextScaleSettingCard();

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final textScaleResource = context.watch<TextScaleResource>();
    final currentScale = textScaleResource.value?.scale(1) ?? 1.0;
    final isAuto = textScaleResource.value == null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Text Scale',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Smaller button
                _ScaleButton(
                  icon: Icons.remove,
                  onPressed: () {
                    final newScale = (currentScale - 0.1).clamp(0.5, 2.0);
                    textScaleResource.setScale(newScale);
                  },
                ),
                const SizedBox(width: 12),

                // Current value display
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        isAuto ? 'Auto' : '${(currentScale * 100).round()}%',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Bigger button
                _ScaleButton(
                  icon: Icons.add,
                  onPressed: () {
                    final newScale = (currentScale + 0.1).clamp(0.5, 2.0);
                    textScaleResource.setScale(newScale);
                  },
                ),
                const SizedBox(width: 12),

                // Auto button
                FilledButton(
                  onPressed: textScaleResource.useSystemScale,
                  style: FilledButton.styleFrom(
                    backgroundColor: isAuto
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                    foregroundColor: isAuto
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface,
                  ),
                  child: const Text('Auto'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ScaleButton extends StatelessWidget {
  const _ScaleButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }
}

class _ThemeBrightnessSettingCard extends StatelessWidget {
  const _ThemeBrightnessSettingCard();

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final themeBrightnessResource = context.watch<ThemeBrightnessResource>();
    final currentMode = themeBrightnessResource.value;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _ThemeButton(
                    label: 'Light',
                    icon: Icons.light_mode,
                    isSelected: currentMode == ThemeMode.light,
                    onPressed: themeBrightnessResource.setLightMode,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ThemeButton(
                    label: 'Dark',
                    icon: Icons.dark_mode,
                    isSelected: currentMode == ThemeMode.dark,
                    onPressed: themeBrightnessResource.setDarkMode,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ThemeButton(
                    label: 'System',
                    icon: Icons.settings_brightness,
                    isSelected: currentMode == ThemeMode.system,
                    onPressed: themeBrightnessResource.setSystemMode,
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

class _ThemeButton extends StatelessWidget {
  const _ThemeButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.surfaceContainerHighest,
        foregroundColor: isSelected
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
