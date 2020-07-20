import 'dart:io';

class AdmobService {
  static String getAdMobAppId() {
    if (Platform.isIOS) {
      // TODO: return iOS string
      return null;
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-5741020440631678~6845475412';
    }
    return null;
  }

  static String getBannerAdId() {
    if (Platform.isIOS) {
      // TODO: return iOS string
      return null;
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-5741020440631678/3697116637';
    }
    return null;
  }
}
