import 'package:flutter/material.dart';

/// A reusable empty state display widget.
///
/// Typically shown when a list is empty, search results are blank, or a network error occurs.
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.action,
  });

  final Widget title;
  final Widget? description;
  final Widget? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(height: 16),
            ],
            DefaultTextStyle.merge(
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ) ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              child: title,
            ),
            if (description != null) ...[
              const SizedBox(height: 8),
              DefaultTextStyle.merge(
                style: theme.textTheme.bodyMedium?.copyWith(
                  // ignore: deprecated_member_use
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                ) ?? const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
                child: description!,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
