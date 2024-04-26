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

    // TODO: 나중에 지울 녀석임
    final user = authenticationController.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login View"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user == null
                ? const Text('유저가 현재 로그아웃 상태입니다.')
                : const Text('유저가 로그인 상태입니다.'),
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
