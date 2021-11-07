import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../services/ad_state.dart';
import '../services/ads_manager.dart';
import '../utils/anchored_adaptive_banner_adSize.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_stickers_flutter/screens/StickerList.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd banner;
  bool showAd = true;
  AnchoredAdaptiveBannerAdSize size;

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   banner.dispose();
  //   super.dispose();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((value) async {
      size = await anchoredAdaptiveBannerAdSize(context);
      setState(() {
        if (adState.bannerAdUnitId != null) {
          banner = BannerAd(
            listener: adState.adListener,
            adUnitId: BannerAd.testAdUnitId, //adState.bannerAdUnitId,
            request: AdRequest(),
            size: size,
          )..load();
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    

    // banner = BannerAd(
    //     adUnitId: BannerAd.testAdUnitId,
    //     size: AdSize.fullBanner,
    //     request: AdRequest(),
    //     listener: BannerAdListener(onAdLoaded: (Ad ad) async {
    //       // print("==AD ID=>" + ad.responseInfo.responseId);
    //       // if (await AdsGlobalUtils.isAdDisplayable(
    //       //     ad.responseInfo.responseId, 'banner')) {
    //       //   print(
    //       //       "BANNER HAS BEEN APPROVED ======");
    //       //   showAdState(true);
    //       // } else {
    //       //  ad.dispose();
    //       //   showAdState(false);
    //       //   print(
    //       //       " HOME BANNER NOT APPROVED =====");
    //       // }
    //     }));
    // banner.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trendy Stickers',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.grey,
              ),
              onPressed: () {
                Share.text(
                    'Share App',
                    'https://play.google.com/store/apps/details?id=com.noorisofttech.trendy_stickers',
                    'text/plain');
              }),
          IconButton(
              icon: Icon(
                Icons.star_rate,
                color: Colors.grey,
              ),
              onPressed: () {
                _launchURL();
              }),
        ],
      ),
      body: Stack(
        children: [
          StickerList(banner: banner),
          Positioned(
            bottom: 3,
            child: Container(
                width: size.width.toDouble(),
                height: size.height.toDouble(),
                child: /* trenary to check if the id exist in the db then take an action*/
                    Visibility(
                        visible: showAd,
                        child: banner == null
                            ? SizedBox()
                            : AdWidget(ad: banner))),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.noorisofttech.trendy_stickers';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
