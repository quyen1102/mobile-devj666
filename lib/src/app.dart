import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:l10n_esperanto/l10n_esperanto.dart';
import 'package:nf_base/l10n/l10n.dart';
import 'package:nf_base/src/app_links_service.dart';
import 'package:nf_base/src/binding.dart';
import 'package:nf_base/src/constants.dart';
import 'package:nf_base/src/model/account/account_repository.dart';
import 'package:nf_base/src/model/account/account_service.dart';
import 'package:nf_base/src/model/announce/announce_service.dart';
import 'package:nf_base/src/model/common/preloaded_data.dart';
import 'package:nf_base/src/model/log/app_log_service.dart';
import 'package:nf_base/src/model/message/message_service.dart';
import 'package:nf_base/src/model/notifications/notification_service.dart';
import 'package:nf_base/src/model/settings/general_preferences.dart';
import 'package:nf_base/src/network/connectivity.dart';
import 'package:nf_base/src/network/socket.dart';
import 'package:nf_base/src/quick_actions.dart';
import 'package:nf_base/src/tab_scaffold.dart';
import 'package:nf_base/src/theme.dart';
import 'package:nf_base/src/utils/screen.dart';

const String _kIosAppGroupId = 'group.com.example.base.widgets';
const List<String> _kIosBlogWidgetKinds = [
  'OfficialBlogWidget',
  'CommunityBlogWidget',
  'UserBlogFeedWidget',
];

/// Application initialization and main entry point.
class AppInitializationScreen extends ConsumerWidget {
  const AppInitializationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<PreloadedData>>(preloadedDataProvider, (_, state) {
      if (state.hasValue || state.hasError) {
        FlutterNativeSplash.remove();
      }
    });

    switch (ref.watch(preloadedDataProvider)) {
      case AsyncData():
        return const Application();
      case AsyncError(:final error, :final stackTrace):
        debugPrint('SEVERE: [App] could not initialize app; $error\n$stackTrace');
        return const SizedBox.shrink();
      case _:
        // loading screen is handled by the native splash screen
        return const SizedBox.shrink();
    }
  }
}

/// The main application widget.
///
/// This widget is the root of the application and is responsible for setting up
/// the theme, locale, and other global settings.
class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ConsumerState<Application> createState() => _AppState();
}

class _AppState extends ConsumerState<Application> {
  /// Whether the app has checked for online status for the first time.
  bool _firstTimeOnlineCheck = false;
  final _navigatorKey = GlobalKey<NavigatorState>();

  // Adjusts some settings based on screen size if necessary.
  Future<void> _screenSizeBasedInitialization(WidgetRef ref) async {
    // Screen size specific initialization placeholder
  }

  @override
  void initState() {
    _screenSizeBasedInitialization(ref);

    // Start core background services
    ref.read(appLogServiceProvider).start();
    ref.read(notificationServiceProvider).start();
    ref.read(messageServiceProvider).start();
    ref.read(accountServiceProvider).start();
    ref.read(quickActionServiceProvider).start();
    ref.read(announceServiceProvider).start();
    ref.read(appLinksServiceProvider).start();

    if (Platform.isIOS) {
      HomeWidget.setAppGroupId(_kIosAppGroupId);
    }

    // Listen for connectivity changes and perform actions accordingly.
    ref.listenManual(connectivityChangesProvider, (prev, current) async {
      final socketClient = ref.read(socketPoolProvider).currentClient;
      if (current.value?.isOnline == true &&
          current.value?.appState == AppLifecycleState.resumed &&
          !socketClient.isActive) {
        socketClient.connect();
      } else if (current.value?.isOnline == false) {
        socketClient.close();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final generalPrefs = ref.watch(generalPreferencesProvider);
    final theme = makeAppTheme(context, generalPrefs);

    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return MaterialApp(
      navigatorKey: _navigatorKey,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        MaterialLocalizationsEo.delegate,
        CupertinoLocalizationsEo.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'BaseApp',
      locale: generalPrefs.locale,
      theme: theme.copyWith(
        navigationBarTheme: isIOS
            ? null
            : NavigationBarTheme.of(
                context,
              ).copyWith(height: isShortVerticalScreen(context) ? 60 : null),
      ),
      home: const MainTabScaffold(),
      navigatorObservers: [rootNavPageRouteObserver],
    );
  }
}
