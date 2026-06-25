import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:nf_base/l10n/l10n.dart';
import 'package:nf_base/src/constants.dart';
import 'package:nf_base/src/utils/l10n_context.dart';
import 'package:nf_base/src/view/home/home_tab_screen.dart';
import 'package:nf_base/src/view/settings/settings_screen.dart';
import 'package:nf_base/src/widgets/background.dart';
import 'package:material_symbols_icons/symbols.dart';

enum BottomTab {
  home,
  notifications,
  settings,
  account;

  String label(AppLocalizations strings) {
    switch (this) {
      case BottomTab.home:
        return 'Home';
      case BottomTab.notifications:
        return 'Notifications';
      case BottomTab.settings:
        return 'Settings';
      case BottomTab.account:
        return 'Account';
    }
  }

  IconData get icon {
    switch (this) {
      case BottomTab.home:
        return Symbols.home_rounded;
      case BottomTab.notifications:
        return Symbols.notifications_rounded;
      case BottomTab.settings:
        return Symbols.settings_rounded;
      case BottomTab.account:
        return Symbols.person_rounded;
    }
  }
}

final currentBottomTabProvider = StateProvider<BottomTab>((ref) => BottomTab.home);

final currentNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  final currentTab = ref.watch(currentBottomTabProvider);
  switch (currentTab) {
    case BottomTab.home:
      return homeNavigatorKey;
    case BottomTab.notifications:
      return notificationsNavigatorKey;
    case BottomTab.settings:
      return settingsNavigatorKey;
    case BottomTab.account:
      return accountNavigatorKey;
  }
});

final currentRootScrollControllerProvider = Provider<ScrollController>((ref) {
  final currentTab = ref.watch(currentBottomTabProvider);
  switch (currentTab) {
    case BottomTab.home:
      return homeScrollController;
    case BottomTab.notifications:
      return notificationsScrollController;
    case BottomTab.settings:
      return settingsScrollController;
    case BottomTab.account:
      return accountScrollController;
  }
});

final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final notificationsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'notifications');
final settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');
final accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

final homeScrollController = ScrollController(debugLabel: 'HomeScroll');
final notificationsScrollController = ScrollController(debugLabel: 'NotificationsScroll');
final settingsScrollController = ScrollController(debugLabel: 'SettingsScroll');
final accountScrollController = ScrollController(debugLabel: 'AccountScroll');

final RouteObserver<PageRoute<void>> rootNavPageRouteObserver = RouteObserver<PageRoute<void>>();

final homeTabInteraction = _BottomTabInteraction();
final notificationsTabInteraction = _BottomTabInteraction();
final settingsTabInteraction = _BottomTabInteraction();
final accountTabInteraction = _BottomTabInteraction();

class _BottomTabInteraction extends ChangeNotifier {
  void notifyItemTapped() {
    notifyListeners();
  }
}

class MainTabScaffold extends ConsumerWidget {
  const MainTabScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(currentBottomTabProvider);
    final extendBody = Theme.of(context).platform == TargetPlatform.iOS;

    return FullScreenBackground(
      child: MainTabScaffoldProperties(
        extendBody: extendBody,
        child: Scaffold(
          body: _TabSwitchingView(currentTab: currentTab, tabBuilder: _tabBuilder),
          extendBody: extendBody,
          bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS
              ? _CupertinoTabBar(
                  height: 50,
                  backgroundColor: NavigationBarTheme.of(context).backgroundColor,
                  border: const Border(top: BorderSide(color: Colors.transparent)),
                  activeColor: ColorScheme.of(context).onSurface,
                  currentIndex: currentTab.index,
                  items: [
                    for (final tab in BottomTab.values)
                      BottomNavigationBarItem(
                        icon: Icon(tab.icon, fill: tab == currentTab ? 1 : 0),
                        label: tab.label(context.l10n),
                      ),
                  ],
                  onTap: (i) => _onItemTapped(ref, i),
                )
              : NavigationBar(
                  selectedIndex: currentTab.index,
                  destinations: [
                    for (final tab in BottomTab.values)
                      NavigationDestination(
                        icon: Icon(tab.icon, fill: tab == currentTab ? 1 : 0),
                        label: tab.label(context.l10n),
                      ),
                  ],
                  onDestinationSelected: (i) => _onItemTapped(ref, i),
                ),
        ),
      ),
    );
  }

  void _onItemTapped(WidgetRef ref, int index) {
    final curTab = ref.read(currentBottomTabProvider);
    final tappedTab = BottomTab.values[index];

    if (tappedTab == curTab) {
      final navState = ref.read(currentNavigatorKeyProvider).currentState;
      final scrollController = ref.read(currentRootScrollControllerProvider);
      if (navState?.canPop() == true) {
        navState?.popUntil((route) => route.isFirst);
      } else if (scrollController.hasClients && scrollController.offset > 0) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        switch (tappedTab) {
          case BottomTab.home:
            homeTabInteraction.notifyItemTapped();
          case BottomTab.notifications:
            notificationsTabInteraction.notifyItemTapped();
          case BottomTab.settings:
            settingsTabInteraction.notifyItemTapped();
          case BottomTab.account:
            accountTabInteraction.notifyItemTapped();
        }
      }
    } else {
      ref.read(currentBottomTabProvider.notifier).state = tappedTab;
    }
  }

  Widget _tabBuilder(BuildContext context, int index) {
    switch (index) {
      case 0:
        return _MaterialTabView(
          navigatorKey: homeNavigatorKey,
          tab: BottomTab.home,
          builder: (context) => const HomeTabScreen(),
        );
      case 1:
        return _MaterialTabView(
          navigatorKey: notificationsNavigatorKey,
          tab: BottomTab.notifications,
          builder: (context) => const _NotificationsPlaceholderScreen(),
        );
      case 2:
        return _MaterialTabView(
          navigatorKey: settingsNavigatorKey,
          tab: BottomTab.settings,
          builder: (context) => const SettingsScreen(),
        );
      case 3:
        return _MaterialTabView(
          navigatorKey: accountNavigatorKey,
          tab: BottomTab.account,
          builder: (context) => const _AccountPlaceholderScreen(),
        );
      default:
        assert(false, 'Unexpected tab');
        return const SizedBox.shrink();
    }
  }
}

class _NotificationsPlaceholderScreen extends StatelessWidget {
  const _NotificationsPlaceholderScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Symbols.notifications, size: 64),
            SizedBox(height: 16),
            Text('No notifications yet.'),
          ],
        ),
      ),
    );
  }
}

class _AccountPlaceholderScreen extends StatelessWidget {
  const _AccountPlaceholderScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Symbols.person, size: 64),
            SizedBox(height: 16),
            Text('Guest User'),
          ],
        ),
      ),
    );
  }
}

class MainTabScaffoldProperties extends InheritedWidget {
  const MainTabScaffoldProperties({required super.child, required this.extendBody, super.key});

  final bool extendBody;

  @override
  bool updateShouldNotify(MainTabScaffoldProperties oldWidget) {
    return extendBody != oldWidget.extendBody;
  }

  static MainTabScaffoldProperties? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainTabScaffoldProperties>();
  }

  static bool hasExtendedBody(BuildContext context) {
    final properties = maybeOf(context);
    return properties != null && properties.extendBody;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('extendBody', extendBody));
  }
}

class _TabSwitchingView extends StatefulWidget {
  const _TabSwitchingView({required this.currentTab, required this.tabBuilder});

  final BottomTab currentTab;
  final WidgetBuilder2 tabBuilder;

  @override
  _TabSwitchingViewState createState() => _TabSwitchingViewState();
}

typedef WidgetBuilder2 = Widget Function(BuildContext context, int index);

class _TabSwitchingViewState extends State<_TabSwitchingView> {
  final List<bool> shouldBuildTab = <bool>[];
  final List<FocusScopeNode> tabFocusNodes = <FocusScopeNode>[];
  final List<FocusScopeNode> discardedNodes = <FocusScopeNode>[];

  @override
  void initState() {
    super.initState();
    shouldBuildTab.addAll(List<bool>.filled(BottomTab.values.length, false));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusActiveTab();
  }

  @override
  void didUpdateWidget(_TabSwitchingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _focusActiveTab();
  }

  void _focusActiveTab() {
    if (tabFocusNodes.length != BottomTab.values.length) {
      if (tabFocusNodes.length > BottomTab.values.length) {
        discardedNodes.addAll(tabFocusNodes.sublist(BottomTab.values.length));
        tabFocusNodes.removeRange(BottomTab.values.length, tabFocusNodes.length);
      } else {
        tabFocusNodes.addAll(
          List<FocusScopeNode>.generate(
            BottomTab.values.length - tabFocusNodes.length,
            (int index) =>
                FocusScopeNode(debugLabel: '$MainTabScaffold Tab ${index + tabFocusNodes.length}'),
          ),
        );
      }
    }
    FocusScope.of(context).setFirstFocus(tabFocusNodes[widget.currentTab.index]);
  }

  @override
  void dispose() {
    for (final FocusScopeNode focusScopeNode in tabFocusNodes) {
      focusScopeNode.dispose();
    }
    for (final FocusScopeNode focusScopeNode in discardedNodes) {
      focusScopeNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: List<Widget>.generate(BottomTab.values.length, (int index) {
        final bool active = index == widget.currentTab.index;
        shouldBuildTab[index] = active || shouldBuildTab[index];

        return HeroMode(
          enabled: active,
          child: Offstage(
            offstage: !active,
            child: TickerMode(
              enabled: active,
              child: FocusScope(
                node: tabFocusNodes[index],
                child: Builder(
                  builder: (BuildContext context) {
                    return shouldBuildTab[index] ? widget.tabBuilder(context, index) : Container();
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _MaterialTabView extends ConsumerStatefulWidget {
  const _MaterialTabView({
    super.key,
    required this.tab,
    this.builder,
    this.navigatorKey,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.restorationScopeId,
  });

  final BottomTab tab;
  final WidgetBuilder? builder;
  final GlobalKey<NavigatorState>? navigatorKey;
  final List<NavigatorObserver> navigatorObservers;
  final String? restorationScopeId;

  @override
  ConsumerState<_MaterialTabView> createState() => _MaterialTabViewState();
}

class _MaterialTabViewState extends ConsumerState<_MaterialTabView> {
  late HeroController _heroController;
  late List<NavigatorObserver> _navigatorObservers;

  @override
  void initState() {
    super.initState();
    _heroController = MaterialApp.createMaterialHeroController();
    _updateObservers();
  }

  @override
  void didUpdateWidget(_MaterialTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navigatorKey != oldWidget.navigatorKey ||
        widget.navigatorObservers != oldWidget.navigatorObservers) {
      _updateObservers();
    }
  }

  void _updateObservers() {
    _navigatorObservers = List<NavigatorObserver>.of(widget.navigatorObservers)
      ..add(_heroController);
  }

  @override
  Widget build(BuildContext context) {
    final currentTab = ref.watch(currentBottomTabProvider);
    final enablePopHandler = currentTab == widget.tab;
    return NavigatorPopHandler(
      onPopWithResult: enablePopHandler
          ? (_) {
              widget.navigatorKey?.currentState?.maybePop();
            }
          : null,
      enabled: enablePopHandler,
      child: Navigator(
        key: widget.navigatorKey,
        onGenerateRoute: _onGenerateRoute,
        observers: _navigatorObservers,
        restorationScopeId: widget.restorationScopeId,
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    WidgetBuilder? routeBuilder;
    if (name == Navigator.defaultRouteName && widget.builder != null) {
      routeBuilder = widget.builder;
    }
    if (routeBuilder != null) {
      return MaterialPageRoute<dynamic>(builder: routeBuilder, settings: settings);
    }
    return null;
  }
}

const double _kTabBarHeight = 50.0;
const Color _kDefaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x4D000000),
  darkColor: Color(0x29000000),
);
const Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;

class _CupertinoTabBar extends StatelessWidget implements PreferredSizeWidget {
  const _CupertinoTabBar({
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor = _kDefaultTabBarInactiveColor,
    this.iconSize = 30.0,
    this.height = _kTabBarHeight,
    this.border = const Border(
      top: BorderSide(
        color: _kDefaultTabBarBorderColor,
        width: 0.0,
      ),
    ),
  });

  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color inactiveColor;
  final double iconSize;
  final double height;
  final Border? border;

  @override
  Size get preferredSize => Size.fromHeight(height);

  bool opaque(BuildContext context) {
    final Color backgroundColor =
        this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor;
    return CupertinoDynamicColor.resolve(backgroundColor, context).a == 1.0;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final double bottomPadding = MediaQuery.viewPaddingOf(context).bottom;

    final Color backgroundColor = CupertinoDynamicColor.resolve(
      this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
      context,
    );

    BorderSide resolveBorderSide(BorderSide side) {
      return side == BorderSide.none
          ? side
          : side.copyWith(color: CupertinoDynamicColor.resolve(side.color, context));
    }

    final Border? resolvedBorder = border == null || border.runtimeType != Border
        ? border
        : Border(
            top: resolveBorderSide(border!.top),
            left: resolveBorderSide(border!.left),
            bottom: resolveBorderSide(border!.bottom),
            right: resolveBorderSide(border!.right),
          );

    final Color inactive = CupertinoDynamicColor.resolve(inactiveColor, context);
    Widget result = DecoratedBox(
      decoration: BoxDecoration(border: resolvedBorder, color: backgroundColor),
      child: SizedBox(
        height: height + bottomPadding,
        child: IconTheme.merge(
          data: IconThemeData(color: inactive, size: iconSize),
          child: DefaultTextStyle(
            style: CupertinoTheme.of(context).textTheme.tabLabelTextStyle.copyWith(color: inactive),
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Semantics(
                explicitChildNodes: true,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _buildTabItems(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (!opaque(context)) {
      result = ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: kCupertinoBarBlurSigma, sigmaY: kCupertinoBarBlurSigma),
          child: result,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildTabItems(BuildContext context) {
    final List<Widget> result = <Widget>[];
    final CupertinoLocalizations localizations = CupertinoLocalizations.of(context);

    for (int index = 0; index < items.length; index += 1) {
      final bool active = index == currentIndex;
      result.add(
        _wrapActiveItem(
          context,
          Expanded(
            child: TextFieldTapRegion(
              child: Semantics(
                selected: active,
                hint: localizations.tabSemanticsLabel(tabIndex: index + 1, tabCount: items.length),
                child: MouseRegion(
                  cursor: kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onTap == null
                        ? null
                        : () {
                            onTap!(index);
                          },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: _buildSingleTabItem(items[index], active),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          active: active,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildSingleTabItem(BottomNavigationBarItem item, bool active) {
    return <Widget>[
      Expanded(child: Center(child: active ? item.activeIcon : item.icon)),
      if (item.label != null) Text(item.label!),
    ];
  }

  Widget _wrapActiveItem(BuildContext context, Widget item, {required bool active}) {
    if (!active) {
      return item;
    }

    final Color activeColor = CupertinoDynamicColor.resolve(
      this.activeColor ?? CupertinoTheme.of(context).primaryColor,
      context,
    );
    return IconTheme.merge(
      data: IconThemeData(color: activeColor),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: activeColor),
        child: item,
      ),
    );
  }
}
