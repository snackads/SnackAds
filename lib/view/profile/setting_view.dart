import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/authentication_controller.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationController>(context);

    auth.isUserLoggedOut = () {
      context.go('/login');
    };

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Settings",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit_note_outlined),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    title: const Text('Edit Profile'),
                    onTap: () {
                      context.push('/edit');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_center),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    title: const Text('Help and Support'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete_forever),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    title: const Text('Delete Account'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    title: const Text('Log Out'),
                    onTap: () {
                      auth.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
