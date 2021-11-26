import 'package:tapdaq_flutter/tapdaq_flutter.dart';

const APP_ID = "619f90fa08fe6c2d735d7425";
const CLIENT_KEY = "57bcee04-1fe9-4097-afae-669f18e9ce46";
const Map BANNER_STANDARD_SIZE = {'width': 320.0, 'height': 30.0};

class AdsManager {
  static Tapdaq tapdaq = Tapdaq(
      appId: APP_ID,
      clientKey: CLIENT_KEY,
      consentStatus: true,
      gdpr: true,
      restricted: false);

  static TapdaqBanner bannerInit() {
    return TapdaqBanner(adTag: 'default', adSize: BANNER_STANDARD_SIZE);
  }

  static TapdaqInterstitial interInit() {
    return TapdaqInterstitial(adTag: 'default');
  }
}
