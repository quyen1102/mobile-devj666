import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nf_base/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A singleton class that provides access to plugins and external APIs.
///
/// Only one instance of this class will be created during the app's lifetime.
/// See [AppBinding] for the concrete implementation.
///
/// Modeled after the Flutter framework's [WidgetsBinding] class.
///
/// The preferred way to mock or fake a plugin or external API is to create a
/// provider with riverpod because it gives more flexibility and control over
/// the behavior of the fake.
/// However, if the plugin is used in a way that doesn't allow for easy mocking
/// with riverpod, a test binding can be used to provide a fake implementation.
abstract class BaseAppBinding {
  BaseAppBinding() : assert(_instance == null) {
    initInstance();
  }

  /// The single instance of [BaseAppBinding].
  static BaseAppBinding get instance => checkInstance(_instance);
  static BaseAppBinding? _instance;

  @protected
  @mustCallSuper
  void initInstance() {
    _instance = this;
  }

  static T checkInstance<T extends BaseAppBinding>(T? instance) {
    assert(() {
      if (instance == null) {
        throw FlutterError.fromParts([
          ErrorSummary('App binding has not yet been initialized.'),
          ErrorHint(
            'In the app, this is done by the `AppBinding.ensureInitialized()` call '
            'in the `void main()` method.',
          ),
          ErrorHint(
            'In a test, one can call `TestAppBinding.ensureInitialized()` as the '
            "first line in the test's `main()` method to initialize the binding.",
          ),
        ]);
      }
      return true;
    }());
    return instance!;
  }

  /// Counts how many times the app has been (cold) started.
  int get numAppStarts;

  /// The shared preferences instance. Must be preloaded before use.
  ///
  /// This is a synchronous getter that throws an error if shared preferences
  /// have not yet been initialized.
  SharedPreferencesWithCache get sharedPreferences;

  /// Initialize Firebase.
  ///
  /// This wraps [Firebase.initializeApp].
  ///
  /// This should be called only once before the app starts.
  Future<void> initializeFirebase();

  /// Wraps [FirebaseMessaging.instance].
  FirebaseMessaging get firebaseMessaging;

  /// Wraps [FirebaseCrashlytics.instance].
  FirebaseCrashlytics get firebaseCrashlytics;

  /// Wraps [FirebaseMessaging.onMessage].
  Stream<RemoteMessage> get firebaseMessagingOnMessage;

  /// Wraps [FirebaseMessaging.onMessageOpenedApp].
  Stream<RemoteMessage> get firebaseMessagingOnMessageOpenedApp;

  /// Wraps [FirebaseMessaging.onBackgroundMessage].
  void firebaseMessagingOnBackgroundMessage(BackgroundMessageHandler handler);
}

/// A concrete implementation of [BaseAppBinding] for the app.
class AppBinding extends BaseAppBinding {
  AppBinding();

  /// Returns an instance of the binding that implements [BaseAppBinding].
  ///
  /// If no binding has yet been initialized, the [AppBinding] class is
  /// used to create and initialize one.
  factory AppBinding.ensureInitialized() {
    if (BaseAppBinding._instance == null) {
      AppBinding();
    }
    return BaseAppBinding.instance as AppBinding;
  }

  late Future<SharedPreferencesWithCache> _sharedPreferencesWithCache;
  SharedPreferencesWithCache? _syncSharedPreferencesWithCache;

  @override
  SharedPreferencesWithCache get sharedPreferences {
    if (_syncSharedPreferencesWithCache == null) {
      throw FlutterError.fromParts([
        ErrorSummary('Shared preferences have not yet been preloaded.'),
        ErrorHint(
          'In the app, this is done by the `await AppBinding.preloadSharedPreferences()` call '
          'in the `Future<void> main()` method.',
        ),
        ErrorHint(
          'In a test, one can call `TestAppBinding.setInitialSharedPreferencesValues({})` as the '
          "first line in the test's `main()` method.",
        ),
      ]);
    }
    return _syncSharedPreferencesWithCache!;
  }

  static const String _kNumAppStartsKey = 'app_starts';

  @override
  int get numAppStarts => sharedPreferences.getInt(_kNumAppStartsKey) ?? 0;

  /// Preload shared preferences.
  ///
  /// This should be called only once before the app starts. Must be called before
  /// [sharedPreferences] is accessed.
  Future<void> preloadSharedPreferences() async {
    _sharedPreferencesWithCache = SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
    _syncSharedPreferencesWithCache = await _sharedPreferencesWithCache;

    final appStarts = sharedPreferences.getInt(_kNumAppStartsKey) ?? 0;
    sharedPreferences.setInt(_kNumAppStartsKey, appStarts + 1);
  }

  @override
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    if (kReleaseMode) {
      FlutterError.onError = firebaseCrashlytics.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        if (kDebugMode) {
          return false;
        } else {
          firebaseCrashlytics.recordError(error, stack);
          return true;
        }
      };
    }
  }

  @override
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @override
  FirebaseCrashlytics get firebaseCrashlytics => FirebaseCrashlytics.instance;

  @override
  void firebaseMessagingOnBackgroundMessage(BackgroundMessageHandler handler) {
    FirebaseMessaging.onBackgroundMessage(handler);
  }

  @override
  Stream<RemoteMessage> get firebaseMessagingOnMessage => FirebaseMessaging.onMessage;

  @override
  Stream<RemoteMessage> get firebaseMessagingOnMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;
}
