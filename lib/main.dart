import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/app.dart';
import 'package:snack_ads/controller/feed_controller.dart';
import 'package:snack_ads/controller/register_controller.dart';
import 'controller/authentication_controller.dart';
import 'controller/bottom_navigation_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationController()),
        ChangeNotifierProvider(create: (context) => RegisterController()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationController()),
        ChangeNotifierProvider(create: (context) => FeedController()),
      ],
      builder: ((context, child) => const App()),
    ),
  );
}
