import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/authentication_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationController =
        Provider.of<AuthenticationController>(context);
    authenticationController.isUserLoggedIn = () {
      context.go('/main');
    };

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "SNACK ADS",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            ElevatedButton(
              onPressed: () {
                authenticationController.signInWithGoogle();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.google),
                  SizedBox(width: 10),
                  Text("Google Login"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
