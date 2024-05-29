import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snack_ads/controller/shared_feed_controller.dart';
import 'package:snack_ads/controller/shared_link_controller.dart';

class ShareLinkPage extends StatefulWidget {
  final SharedFeedControllor sharedFeedControllor;
  final SharedLinkController sharedLinkController;
  const ShareLinkPage(
      {super.key,
      required this.sharedFeedControllor,
      required this.sharedLinkController});

  @override
  State<ShareLinkPage> createState() => _ShareLinkPageState();
}

class _ShareLinkPageState extends State<ShareLinkPage> {
  @override
  void initState() {
    widget.sharedFeedControllor.loadVideo(widget.sharedLinkController.videoURL);
    super.initState();
  }

  @override
  void dispose() {
    widget.sharedFeedControllor.disposeVideoController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sharedFeedControllor.video.restaurantName),
        backgroundColor: Colors.black,
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
          Text('wow'),
        ],
      ),
    );
  }
}
