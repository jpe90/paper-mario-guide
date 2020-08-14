import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';

class AdmobService {
  static final admobBanner = AdmobBanner(
      adUnitId: getBannerAdId(), adSize: AdmobBannerSize.FULL_BANNER);
  static String getAdMobAppId() {
    if (Platform.isIOS) {
      // TODO: return iOS string
      return null;
    } else if (Platform.isAndroid) {
      return _androidBannerAppId;
    }
    return null;
  }

  //TODO: update this to the correct app ID
  static const _androidBannerAppId = 'ca-app-pub-5741020440631678~6845475412';
  //TODO: update this to the correct banner ad ID
  static const _androidBannerAdId = 'ca-app-pub-3940256099942544/6300978111';
  static String getBannerAdId() {
    if (Platform.isIOS) {
      // TODO: return iOS string
      return null;
    } else if (Platform.isAndroid) {
      //return 'ca-app-pub-5741020440631678/3697116637';
      return _androidBannerAdId;
    }
    return null;
  }
}
