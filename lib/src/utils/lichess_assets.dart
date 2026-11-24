import 'dart:math' show Random;

import 'package:nf_base/src/constants.dart';

final _random = Random();
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
String _generateRandomString(int len) {
  return List.generate(len, (index) => _chars[_random.nextInt(_chars.length)]).join();
}

final String _assetHash = '_${_generateRandomString(6)}';

String lichessAssetUrl(String path) {
  return '$kAppCDNHost/assets/$_assetHash/$path';
}

String lichessFlagSrc(String country) {
  return '$kAppCDNHost/assets/flags/$country.png';
}

String lichessFlairSrc(String flair) {
  return '$kAppCDNHost/assets/flair/img/$flair.webp';
}
