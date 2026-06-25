import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nf_base/src/model/settings/general_preferences.dart';
import 'package:nf_base/src/utils/color_palette.dart';
import 'package:nf_base/src/utils/l10n_context.dart';
import 'package:nf_base/src/utils/navigation.dart';
import 'package:nf_base/src/view/settings/background_theme_choice_screen.dart';
import 'package:nf_base/src/widgets/list.dart';
import 'package:nf_base/src/widgets/settings.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  static Route<dynamic> buildRoute() {
    return buildScreenRoute(screen: const ThemeSettingsScreen());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generalPrefs = ref.watch(generalPreferencesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.mobileTheme)),
      body: SafeArea(
        child: ListView(
          children: [
            ListSection(
              hasLeading: true,
              children: [
                if (getCorePalette() != null)
                  SwitchSettingTile(
                    leading: const Icon(Icons.colorize_outlined),
                    title: Text(context.l10n.mobileSystemColors),
                    value: generalPrefs.systemColors,
                    onChanged: (value) {
                      ref.read(generalPreferencesProvider.notifier).toggleSystemColors();
                    },
                  ),
                SettingsListTile(
                  icon: const Icon(Icons.wallpaper),
                  settingsLabel: Text(context.l10n.background),
                  settingsValue: generalPrefs.backgroundColor != null
                      ? generalPrefs.backgroundColor!.$1.label
                      : (generalPrefs.backgroundImage != null ? 'Image' : 'Default'),
                  onTap: () {
                    Navigator.of(context).push(BackgroundChoiceScreen.buildRoute());
                  },
                ),
                if (generalPrefs.backgroundColor != null ||
                    generalPrefs.backgroundImage != null)
                  ListTile(
                    leading: const Icon(Icons.cancel),
                    title: const Text('Reset background'),
                    onTap: () {
                      ref
                          .read(generalPreferencesProvider.notifier)
                          .setBackground(backgroundColor: null, backgroundImage: null);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
