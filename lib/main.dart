import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tapdaq_flutter/tapdaq_flutter.dart';
import 'package:whatsapp_stickers_flutter/screens/SplashScreen.dart';

import 'modals/InstallStickersModal.dart';
import 'modals/StickerListModal.dart';
import 'services/ad_state.dart';

import 'services/ads_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  Tapdaq tapdaq = Tapdaq(
      appId: APP_ID,
      clientKey: CLIENT_KEY,
      consentStatus: true,
      gdpr: true,
      restricted: false);
  tapdaq.initialize();
  
  print("before init Tapdaq");
  runApp(Provider.value(
    value: adState,
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StickerListModel()),
        ChangeNotifierProvider(create: (_) => InstallStickersModal()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trendy Stickers - Whatsapp Stickers',
        theme: ThemeData(
          primaryColor: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
