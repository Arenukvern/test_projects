import 'package:conference_app_2025/data_models/data_models.dart';
import 'package:conference_app_2025/ui_kit/atoms/ui_text.dart';
import 'package:conference_app_2025/ui_kit/decorations/decorations.dart';
import 'package:conference_app_2025/ui_kit/molecules/molecules.dart';
import 'package:flutter/material.dart';

class UiErrorMessagesBanner extends StatelessWidget {
  const UiErrorMessagesBanner({
    required this.messages,
    required this.onRetry,
    required this.onDismiss,
    super.key,
    this.showDismissButton = false,
  });

  final List<AppMessage> messages;
  final VoidCallback onRetry;
  final bool showDismissButton;
  final void Function(AppMessageId messageId) onDismiss;

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final errorMessages = messages
        .where((final m) => m.type == AppMessageType.error)
        .toList();

    if (errorMessages.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: theme.colorScheme.error,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: UiText(
                  errorMessages.first.message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ),
              if (showDismissButton)
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: theme.colorScheme.onErrorContainer,
                  ),
                  onPressed: () => onDismiss(errorMessages.first.id),
                  tooltip: 'Dismiss',
                ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: UiButton(
              onPressed: () {
                // Dismiss message and retry
                onDismiss(errorMessages.first.id);
                onRetry();
              },
              icon: const Icon(Icons.refresh),
              text: 'Retry',
              decoration: UiButtonDecoration.create(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
