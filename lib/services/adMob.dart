import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMob extends GetxService {
  late BannerAd banner;
  Future<AdMob> inicia() async {
    await MobileAds.instance.initialize();
    banner = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.getSmartBanner(Orientation.portrait),
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {},
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
        },
      ),
    );
    return this;
  }

  String get bannerAdUnitId {
    if (GetPlatform.isAndroid) {
      return "ca-app-pub-1205611887737485/5222613657";
    } else if (GetPlatform.isIOS) {
      return "ca-app-pub-1205611887737485/5222613657";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  String get nativeAdUnitId {
    if (GetPlatform.isAndroid) {
      return "ca-app-pub-1205611887737485/6215011566";
    } else if (GetPlatform.isIOS) {
      return "ca-app-pub-1205611887737485/6215011566";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
