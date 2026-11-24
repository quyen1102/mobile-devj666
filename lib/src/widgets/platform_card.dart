import 'package:flutter/material.dart';

/// A platform-adaptive card container.
///
/// Renders a flat container with a subtle border on iOS,
/// and an elevated Material [Card] on Android.
class PlatformCard extends StatelessWidget {
  const PlatformCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final fallbackRadius = borderRadius ?? BorderRadius.circular(12);

    Widget content = Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: fallbackRadius,
        child: content,
      );
    }

    if (isIOS) {
      return Container(
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).cardColor,
          borderRadius: fallbackRadius,
          border: Border.all(
            // ignore: deprecated_member_use
            color: Theme.of(context).dividerColor.withOpacity(0.08),
            width: 0.8,
          ),
        ),
        child: ClipRRect(
          borderRadius: fallbackRadius,
          child: content,
        ),
      );
    } else {
      return Card(
        margin: margin ?? EdgeInsets.zero,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: fallbackRadius,
        ),
        elevation: 1,
        child: ClipRRect(
          borderRadius: fallbackRadius,
          child: content,
        ),
      );
    }
  }
}
