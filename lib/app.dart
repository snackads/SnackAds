import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/feed_upload_controller.dart';
import 'package:snack_ads/view/auth/login_view.dart';
import 'package:snack_ads/view/auth/registration_view.dart';
import 'package:snack_ads/view/feed_upload/feed_upload_video_view.dart';
import 'package:snack_ads/view/main_view.dart';
import 'package:snack_ads/view/profile_view.dart';

late FeedUploadController feedUploadController;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
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
      path: '/register',
      builder: (context, state) => const RegistrationView(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileView(),
    ),
    GoRoute(
      path: '/videoUpload',
      builder: (context, state) => FeedUploadVideoView(
        feedUploadController: feedUploadController,
      ),
    ),
  ],
);
