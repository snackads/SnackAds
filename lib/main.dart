import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/app.dart';
import 'package:snack_ads/controller/feed_controller.dart';
import 'package:snack_ads/controller/register_controller.dart';
import 'controller/authentication_controller.dart';
import 'controller/bottom_navigation_controller.dart';
import 'controller/report_controller.dart';
import 'firebase_options.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NaverMapSdk.instance.initialize(
      clientId: 'hbclic8td3', // 클라이언트 ID 설정
      onAuthFailed: (ex) {
        log("********* 네이버맵 인증오류 : $ex *********");
      });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationController()),
        ChangeNotifierProvider(create: (context) => RegisterController()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationController()),
        ChangeNotifierProvider(create: (context) => FeedController()),
        ChangeNotifierProvider(create: (context) => ReportController()),
      ],
      builder: ((context, child) => const App()),
    ),
  );
}
