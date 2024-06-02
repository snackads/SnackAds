// ignore_for_file: deprecated_member_use

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/feed_upload_controller.dart';
import 'package:snack_ads/controller/shared_feed_controller.dart';
import 'package:snack_ads/controller/shared_link_controller.dart';
import 'package:snack_ads/view/auth/email/input_sign_in_page.dart';
import 'package:snack_ads/view/auth/login_view.dart';
import 'package:snack_ads/view/auth/registration_view.dart';
import 'package:snack_ads/view/feed_upload/feed_upload_detail_view.dart';
import 'package:snack_ads/view/feed_upload/feed_upload_video_view.dart';
import 'package:snack_ads/view/main_view.dart';
import 'package:snack_ads/view/profile/edit_view.dart';
import 'package:snack_ads/view/profile/profile_view.dart';
import 'package:snack_ads/view/profile/setting_view.dart';
import 'package:snack_ads/view/share_link/share_link_view.dart';

import 'dart:developer' as dev;

late SharedLinkController sharedLinkController;
late SharedFeedControllor sharedFeedControllor;
late FeedUploadController feedUploadController;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    initDynamicLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sharedLinkController = Provider.of<SharedLinkController>(context);
    sharedFeedControllor = Provider.of<SharedFeedControllor>(context);
    feedUploadController = Provider.of<FeedUploadController>(context);
    return MaterialApp.router(
      title: "SnackAds",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      routerConfig: _router,
    );
  }
}

void handleDeepLink(BuildContext context, Uri deepLink) {
  sharedLinkController.updateLink(deepLink.pathSegments.last);
  // 링크에서 동영상 ID를 추출
  dev.log('공유된 영상: $deepLink');
  dev.log('영상 id: ${deepLink.pathSegments.last}');
}

void initDynamicLinks(BuildContext context) async {
  FirebaseDynamicLinks.instance.onLink.listen(
    (PendingDynamicLinkData? pendingDynamicLinkData) {
      if (pendingDynamicLinkData != null) {
        final Uri deepLink = pendingDynamicLinkData.link;
        handleDeepLink(context, deepLink);
      }
    },
  );

  await FirebaseDynamicLinks.instance.getInitialLink().then((value) {
    if (value != null) {
      final Uri deepLink = value.link;
      handleDeepLink(context, deepLink);
    }
  });
}

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => MainView(),
    ),
    GoRoute(
      path: '/email',
      builder: (context, state) => const InputSignInPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegistrationView(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: '/setting',
      builder: (context, state) => const SettingView(),
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => const EditView(),
    ),
    GoRoute(
      path: '/videoUpload',
      builder: (context, state) => FeedUploadVideoView(
        feedUploadController: feedUploadController,
      ),
    ),
    GoRoute(
      path: '/videoUploadDetail',
      builder: (context, state) => FeedUploadDetailView(
        feedUploadController: feedUploadController,
      ),
    ),
    GoRoute(
      path: '/sharedLink',
      builder: (context, state) => ShareLinkPage(
        sharedFeedControllor: sharedFeedControllor,
        sharedLinkController: sharedLinkController,
      ),
    )
  ],
);
