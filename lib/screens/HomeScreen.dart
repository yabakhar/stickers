import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tapdaq_flutter/tapdaq_flutter.dart';
import 'package:whatsapp_stickers_flutter/consts/admob-info.dart';
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
  TapdaqBanner banner;
  bool showAd = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    banner = AdsManager.bannerInit();
    banner.createState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Memoji Stickers',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(
                Icons.share,
                color: Color(0xff62c1d9),
              ),
              onPressed: () {
                Share.share(
                    'Check out 42 Swifty App on playstore https://play.google.com/store/apps/details?id=com.bestickers.hijab',
                    subject: 'Check it out!');
              }),
          TextButton(
              child: Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  padding: const EdgeInsets.all(10.0),
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff62c1d9),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                      child: Text(
                    "More Apps",
                    style: TextStyle(color: Colors.white),
                  ))),
              onPressed: () {
                _launchURL();
              }),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: StickerList(banner: banner),
          ),
          Positioned(
            bottom: 3,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: banner),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://play.google.com/store/apps/developer?id=BeStickers';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
