import 'dart:developer';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/app.dart';
import 'package:snack_ads/controller/edit_controller.dart';
import 'package:snack_ads/controller/feed_controller.dart';
import 'package:snack_ads/controller/map_controller.dart';
import 'package:snack_ads/controller/register_controller.dart';
import 'package:snack_ads/controller/restaurant_controller.dart';
import 'package:snack_ads/controller/shared_feed_controller.dart';
import 'package:snack_ads/controller/shared_link_controller.dart';
import 'package:snack_ads/view/share_link/share_link_view.dart';
import 'controller/authentication_controller.dart';
import 'controller/bottom_navigation_controller.dart';
import 'controller/feed_upload_controller.dart';
import 'controller/feed_report_controller.dart';
import 'firebase_options.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'dart:developer' as dev;

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
        ChangeNotifierProvider(create: (context) => EditController()),
        ChangeNotifierProvider(create: (context) => FeedController()),
        ChangeNotifierProvider(create: (context) => FeedUploadController()),
        ChangeNotifierProvider(create: (context) => FeedReportController()),
        ChangeNotifierProvider(create: (context) => RestaurantController()),
        ChangeNotifierProvider(create: (context) => SharedLinkController()),
        ChangeNotifierProvider(create: (context) => SharedFeedControllor()),
        ChangeNotifierProvider(create: (context) => MapProvider())
      ],
      builder: ((context, child) => const App()),
    ),
  );
}
