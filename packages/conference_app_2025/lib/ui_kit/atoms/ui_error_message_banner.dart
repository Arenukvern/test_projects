import 'package:conference_app_2025/data_models/data_models.dart';
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
                child: Text(
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
            child: ElevatedButton.icon(
              onPressed: () {
                // Dismiss message and retry
                onDismiss(errorMessages.first.id);
                onRetry();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
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
