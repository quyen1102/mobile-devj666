import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarAppTitle extends StatelessWidget {
  const AppBarAppTitle({super.key, this.iconSize = 24});

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.bottom,
            child: Icon(Icons.rocket_launch, size: iconSize),
          ),
          const TextSpan(text: ' BaseApp'),
          TextSpan(
            text: '.org',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
          ),
        ],
      ),
      maxLines: 1,
    );
  }
}

/// A widget that displays a title in the app bar with auto-sizing text.
class AppBarTitleText extends StatelessWidget {
  const AppBarTitleText(
    this.text, {
    super.key,
    this.minFontSize,
    this.maxFontSize,
    this.maxLines = 1,
  }) : assert(maxLines > 0 && maxLines <= 2);

  final String text;
  final int maxLines;
  final double? minFontSize;
  final double? maxFontSize;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      style: maxLines > 1 ? const TextStyle(height: 1) : null,
      minFontSize: minFontSize ?? 15.0,
      maxFontSize:
          maxFontSize ??
          (maxLines > 1 ? 18 : AppBarTheme.of(context).titleTextStyle?.fontSize ?? 20.0),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class AppMessage extends StatefulWidget {
  const AppMessage({super.key, this.style, this.textAlign = TextAlign.start});

  final TextStyle? style;
  final TextAlign textAlign;

  @override
  State<AppMessage> createState() => _AppMessageState();
}

class _AppMessageState extends State<AppMessage> {
  late TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = _handleTap;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  void _handleTap() {
    launchUrl(Uri.parse('https://example.com'));
  }

  @override
  Widget build(BuildContext context) {
    final trans = 'Welcome to the Base App';
    final spans = [
      TextSpan(text: trans),
      const TextSpan(text: ' '),
      TextSpan(
        text: '(Learn more)',
        style: TextStyle(color: ColorScheme.of(context).primary),
        recognizer: _recognizer,
      ),
    ];

    return MergeSemantics(
      child: Text.rich(
        TextSpan(style: widget.style, children: spans),
        textAlign: widget.textAlign,
      ),
    );
  }
}
