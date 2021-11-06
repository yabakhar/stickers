import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_stickers_flutter/screens/SplashScreen.dart';

import 'modals/InstallStickersModal.dart';
import 'modals/StickerListModal.dart';

void main() {
  runApp(MyApp());
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