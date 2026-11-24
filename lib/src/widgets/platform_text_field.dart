import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A platform-adaptive text input field.
///
/// Renders a [CupertinoTextField] on iOS and a standard [TextField] on Android.
class PlatformTextField extends StatelessWidget {
  const PlatformTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLines;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return CupertinoTextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        placeholder: hintText ?? decoration?.hintText,
        prefix: prefix,
        suffix: suffix,
        maxLines: maxLines,
        readOnly: readOnly,
        clearButtonMode: OverlayVisibilityMode.editing,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: CupertinoDynamicColor.resolve(
            CupertinoColors.systemBackground,
            context,
          ),
          border: Border.all(
            color: CupertinoDynamicColor.resolve(
              CupertinoColors.systemGrey4,
              context,
            ),
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      );
    } else {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        maxLines: maxLines,
        readOnly: readOnly,
        decoration: decoration?.copyWith(
              hintText: hintText,
              prefix: prefix,
              suffix: suffix,
            ) ??
            InputDecoration(
              hintText: hintText,
              prefix: prefix,
              suffix: suffix,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
      );
    }
  }
}
