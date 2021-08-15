import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pixelegram/infrastructure/util/util.dart';

/// 广告，正式上线将各种unit_id换成生产环境的
class AdMobWidget extends StatefulWidget {
  const AdMobWidget({Key? key}) : super(key: key);

  @override
  _AdMobWidgetState createState() => _AdMobWidgetState();
}

class _AdMobWidgetState extends State<AdMobWidget> {
  AdNotifier adNotifier = AdNotifier(false);

  late BannerAd adBanner;
  @override
  void initState() {
    super.initState();
    initAd();
  }

  @override
  void dispose() {
    adBanner.dispose();
    adNotifier.dispose();
    super.dispose();
  }

  initAd() async {
    adBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitIdTest,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('Ad loaded.');
            adNotifier.value = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
            print('Ad failed to load: $error');
          },
        ),
        request: AdRequest());

    adBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder<bool>(
            valueListenable: adNotifier,
            builder: (_, value, child) {
              if (value == true) {
                return Container(
                  alignment: Alignment.center,
                  child: AdWidget(
                    ad: adBanner,
                  ),
                  width: adBanner.size.width.toDouble(),
                  height: adBanner.size.height.toDouble(),
                );
              }
              return Container();
            }),
      ),
    );
  }
}

class AdNotifier extends ValueNotifier<bool> {
  AdNotifier(value) : super(value);
}
