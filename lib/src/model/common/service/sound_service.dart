import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nf_base/src/model/settings/general_preferences.dart';
import 'package:logging/logging.dart';

final _logger = Logger('SoundService');

enum Sound {
  move,
  capture,
  explosion,
  lowTime,
  dong,
  error,
  confirmation,
  puzzleStormEnd,
  clock,
  berserk,
}

/// A provider for [SoundService].
final soundServiceProvider = Provider<SoundService>((Ref ref) {
  final service = SoundService(ref);
  ref.onDispose(() => service.release());
  return service;
}, name: 'SoundServiceProvider');

/// Service to play game sounds (Mock implementation).
class SoundService {
  SoundService(this._ref);

  final Ref _ref;

  /// Initialize the sound service.
  static Future<void> initialize() async {
    _logger.info('Initializing mock sound service...');
  }

  /// Play the given sound if sound is enabled.
  Future<void> play(Sound sound, {double volume = 1.0}) async {
    assert((volume >= 0.0) && (volume <= 1.0));
    _logger.fine('Mock play sound: ${sound.name} at volume $volume');
  }

  /// Play the capture sound for the given chess [variant].
  Future<void> playCaptureSound(dynamic variant, {double volume = 1.0}) async {
    _logger.fine('Mock play capture sound for variant: $variant');
  }

  /// Change the sound theme and optionally play a move sound.
  Future<void> changeTheme(SoundTheme theme, {bool playSound = false}) async {
    _logger.info('Mock change theme to: ${theme.label}');
  }

  Future<void> release() async {
    _logger.info('Releasing mock sound service...');
  }
}
