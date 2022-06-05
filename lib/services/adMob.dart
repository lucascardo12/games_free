import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMob {
  Future<void> inicia() async {
    await MobileAds.instance.initialize();
  }

  String get bannerAdUnitId => "ca-app-pub-1205611887737485/5222613657";

  String get nativeAdUnitId => "ca-app-pub-1205611887737485/6215011566";

  Future<BannerAd> loadBanner({required String adUnitId}) async {
    var banner = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {},
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
        },
      ),
    );
    await banner.load();
    return banner;
  }
}
