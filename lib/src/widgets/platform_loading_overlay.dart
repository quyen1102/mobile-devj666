import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A platform-adaptive full-screen loading overlay.
///
/// Displays a loading spinner on top of a child widget when [visible] is true,
/// using blur effects on iOS and a standard translucent overlay on Android.
class PlatformLoadingOverlay extends StatelessWidget {
  const PlatformLoadingOverlay({
    super.key,
    required this.child,
    required this.visible,
    this.message,
  });

  final Widget child;
  final bool visible;
  final String? message;

  @override
  Widget build(BuildContext context) {
    if (!visible) return child;

    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    final progressIndicator = isIOS
        ? const CupertinoActivityIndicator(radius: 15)
        : const CircularProgressIndicator();

    final overlayContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        progressIndicator,
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ],
    );

    return Stack(
      children: [
        child,
        Positioned.fill(
          child: isIOS
              ? ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: ColoredBox(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.3),
                      child: Center(child: overlayContent),
                    ),
                  ),
                )
              : ColoredBox(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.5),
                  child: Center(child: overlayContent),
                ),
        ),
      ],
    );
  }
}
