import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkify/linkify.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

final _logger = Logger('AppLinks');

final appLinksServiceProvider = Provider<AppLinksService>((ref) {
  final service = AppLinksService(ref);
  ref.onDispose(() => service.dispose());
  return service;
});

class AppLinksService {
  AppLinksService(this.ref);

  final Ref ref;

  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> start() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final initialUri = await _appLinks.getInitialLink();
        if (initialUri != null) {
          await _handleUri(initialUri);
        }
      } catch (e, st) {
        _logger.severe('Error handling initial app link: $e\n$st');
      }
    });

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) async {
      try {
        await _handleUri(uri);
      } catch (e, st) {
        _logger.severe('Error handling app link: $e\n$st');
      }
    });
  }

  Future<void> _handleUri(Uri uri) async {
    if (uri.scheme == 'file' || uri.scheme == 'content') {
      return;
    }
    _logger.info('Handling deep link URI: $uri');
    // Implement custom deep link handling logic here
  }

  void dispose() {
    _linkSubscription?.cancel();
  }

  static const kAppLinkifiers = [UrlLinkifier(), EmailLinkifier()];

  /// Handles link clicks in Linkify widgets.
  Future<void> onLinkifyOpen(BuildContext context, LinkableElement link) async {
    final uri = Uri.tryParse(link.url);
    if (uri != null) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }
}
