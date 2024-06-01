import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/feed_controller.dart';
import 'package:snack_ads/controller/shared_feed_controller.dart';
import 'package:snack_ads/controller/shared_link_controller.dart';
import 'package:snack_ads/model/shortform.dart';
import 'package:snack_ads/view/feed/feed_column_buttons.dart';
import 'package:snack_ads/view/feed/feed_view_description.dart';
import 'package:video_player/video_player.dart';

class ShareLinkPage extends StatefulWidget {
  final SharedFeedControllor sharedFeedControllor;
  final SharedLinkController sharedLinkController;
  const ShareLinkPage({
    super.key,
    required this.sharedFeedControllor,
    required this.sharedLinkController,
  });

  @override
  State<ShareLinkPage> createState() => _ShareLinkPageState();
}

class _ShareLinkPageState extends State<ShareLinkPage>
    with SingleTickerProviderStateMixin {
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

  bool _isVisible = false;

  void _togglePlayAndPauseVisibility() {
    setState(() {
      _isVisible = !_isVisible;
      if (_isVisible) {
        Future.delayed(const Duration(milliseconds: 750), () {
          setState(() {
            _isVisible = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SharedFeedControllor sharedFeedControllor =
        Provider.of<SharedFeedControllor>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('공유 영상 보기'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            context.go('/main');
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: (sharedFeedControllor.video.controller != null)
          ? videoScreen()
          : SafeArea(
              child: Stack(
                children: [
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  buttonUITemp(),
                ],
              ),
            ),
    );
  }

  Widget videoScreen() {
    return SafeArea(
      child: (widget.sharedFeedControllor.video.controller!.value.isInitialized)
          ? Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      widget.sharedFeedControllor.video.controller != null
                          ? GestureDetector(
                              onTap: () {
                                _togglePlayAndPauseVisibility();
                                if (widget.sharedFeedControllor.video
                                    .controller!.value.isPlaying) {
                                  widget.sharedFeedControllor.video.controller
                                      ?.pause();
                                } else {
                                  widget.sharedFeedControllor.video.controller
                                      ?.play();
                                }
                              },
                              child: SizedBox.expand(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: SizedBox(
                                    width: widget.sharedFeedControllor.video
                                            .controller?.value.size.width ??
                                        0,
                                    height: widget.sharedFeedControllor.video
                                            .controller?.value.size.height ??
                                        0,
                                    child: VideoPlayer(widget
                                        .sharedFeedControllor
                                        .video
                                        .controller!),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.black,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                      widget.sharedFeedControllor.video.controller != null
                          ? Center(
                              child: AnimatedOpacity(
                                opacity: _isVisible ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 500),
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      (widget.sharedFeedControllor.video
                                              .controller!.value.isPlaying)
                                          ? FontAwesomeIcons.circlePlay
                                          : FontAwesomeIcons.circlePause,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      buttonUI(),
                    ],
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                AbsorbPointer(absorbing: true, child: buttonUITemp()),
              ],
            ),
    );
  }

  Widget buttonUI() {
    FeedController feedProvider = Provider.of<FeedController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.transparent,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FeedViewDescription(
                videoRid: widget.sharedFeedControllor.video.restaurantRid,
                videoRestaurantName:
                    widget.sharedFeedControllor.video.restaurantName,
                videoRestaurantAddress:
                    widget.sharedFeedControllor.video.restaurantAddress,
              ),
              FeedColumnButtons(
                video: widget.sharedFeedControllor.video,
                feedProvider: feedProvider,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonUITemp() {
    FeedController feedProvider = Provider.of<FeedController>(context);
    ShortForm video = ShortForm.defaultShortForm();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.transparent,
              ),
            ],
          ),
          IgnorePointer(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FeedViewDescription(
                  videoRid: '',
                  videoRestaurantName: '',
                  videoRestaurantAddress: '',
                ),
                FeedColumnButtons(
                  video: video,
                  feedProvider: feedProvider,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
