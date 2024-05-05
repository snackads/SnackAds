import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snack_ads/view/auth/login_view.dart';
import 'package:snack_ads/view/auth/registration_view.dart';
import 'package:snack_ads/view/main_view.dart';
import 'package:snack_ads/view/profile_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
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
  ],
);
