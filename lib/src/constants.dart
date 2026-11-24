import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const kAppHost = String.fromEnvironment('APP_HOST', defaultValue: 'app.dev');

const kAppWSHost = String.fromEnvironment(
  'APP_WS_HOST',
  defaultValue: 'socket.app.dev',
);

const kAppWSSecret = String.fromEnvironment(
  'APP_WS_SECRET',
  defaultValue: 'somethingElseInProd',
);

const kAppCDNHost = String.fromEnvironment(
  'APP_CDN_HOST',
  defaultValue: 'https://cdn.app.org',
);

const kAppOpeningExplorerHost = String.fromEnvironment(
  'APP_OPENING_EXPLORER_HOST',
  defaultValue: 'explorer.app.org',
);

const kAppTablebaseHost = String.fromEnvironment(
  'APP_TABLEBASE_HOST',
  defaultValue: 'tablebase.app.org',
);

const kAppCustomUriSchemeName = 'org.app.mobile';

const kAppClientId = 'app_mobile';

const kSRIStorageKey = 'socket_random_identifier';

const kFideRatingsUrl = 'https://ratings.fide.com/profile/';

// lichess
// https://github.com/lichess-org/lila/blob/4562a83cdb263c3ebf7e148c0f666f0ff92b91c7/modules/rating/src/main/Glicko.scala#L71
const kProvisionalDeviation = 110;
const kClueLessDeviation = 230;

// UI
const double kCupertinoBarBlurSigma = 30.0;
const double kCupertinoBarOpacity = 0.8;

const kGoldenRatio = 1.61803398875;

/// Use same box shadows as material widgets with elevation 1.
final List<BoxShadow> boardShadows = defaultTargetPlatform == TargetPlatform.iOS
    ? <BoxShadow>[]
    : kElevationToShadow[1]!;

const kMaxClockTextScaleFactor = 1.94;
const kEmptyWidget = SizedBox.shrink();
const kTabletBoardTableSidePadding = 16.0;

const kBottomBarHeight = 56.0;
const kMaterialPopupMenuMaxWidth = 500.0;

/// The threshold to detect screens with a small remaining height minus board.
const kSmallHeightMinusBoard = 200;
