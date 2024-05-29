import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/share_link_controller.dart';

class ShareLinkPage extends StatelessWidget {
  const ShareLinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    SharedLinkController sharedLinkController =
        Provider.of<SharedLinkController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('공유된 영상'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            context.go('/main');
          },
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(sharedLinkController.videoURL),
        ],
      ),
    );
  }
}
