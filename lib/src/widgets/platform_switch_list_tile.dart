import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A platform-adaptive switch list tile.
///
/// Renders a [CupertinoListTile] with a trailing [CupertinoSwitch] on iOS,
/// and a Material [SwitchListTile] on Android.
class PlatformSwitchListTile extends StatelessWidget {
  const PlatformSwitchListTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.activeColor,
    this.contentPadding,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget title;
  final Widget? subtitle;
  final Color? activeColor;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return CupertinoListTile(
        title: title,
        subtitle: subtitle,
        trailing: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          // ignore: deprecated_member_use
          activeColor: activeColor,
        ),
        additionalInfo: null,
      );
    } else {
      return SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: title,
        subtitle: subtitle,
        // ignore: deprecated_member_use
        activeColor: activeColor,
        contentPadding: contentPadding,
      );
    }
  }
}
