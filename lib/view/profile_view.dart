import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/authentication_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationController =
        Provider.of<AuthenticationController>(context);

    authenticationController.isUserLoggedOut = () {
      // Provider.of<BottomNavigationController>(context, listen: false)
      //     .changeTabIndex(0);
      context.go('/login');
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile View"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Profile View'),
          ElevatedButton(
            onPressed: () {
              authenticationController.signOut();
            },
            child: const Text("SIGN OUT"),
          ),
        ],
      ),
    );
  }
}
