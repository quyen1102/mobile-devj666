import 'package:flutter/material.dart';

/// A circular user avatar widget with network image support, initials fallback, and an active status badge.
class PlatformAvatar extends StatelessWidget {
  const PlatformAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.backgroundColor,
    this.textColor,
    this.isOnline = false,
    this.badgeColor,
  });

  final String? imageUrl;
  final String? initials;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOnline;
  final Color? badgeColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fallbackBgColor = backgroundColor ?? theme.colorScheme.primaryContainer;
    final fallbackTextColor = textColor ?? theme.colorScheme.onPrimaryContainer;

    Widget avatarContent = Text(
      initials?.toUpperCase() ?? '',
      style: TextStyle(
        color: fallbackTextColor,
        fontSize: size * 0.4,
        fontWeight: FontWeight.bold,
      ),
    );

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarContent = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Text(
              initials?.toUpperCase() ?? '',
              style: TextStyle(
                color: fallbackTextColor,
                fontSize: size * 0.4,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              width: size * 0.5,
              height: size * 0.5,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      );
    }

    final avatarCircle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: fallbackBgColor,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Center(child: avatarContent),
      ),
    );

    if (isOnline) {
      final badgeSize = size * 0.28;
      return Stack(
        children: [
          avatarCircle,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: badgeSize,
              height: badgeSize,
              decoration: BoxDecoration(
                color: badgeColor ?? Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.scaffoldBackgroundColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return avatarCircle;
  }
}
