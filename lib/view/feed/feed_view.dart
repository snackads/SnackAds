import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snack_ads/controller/feed_controller.dart';
import 'package:snack_ads/model/shortform.dart';
import 'package:snack_ads/view/feed/feed_button_design.dart';
import 'package:snack_ads/view/feed/feed_buttons.dart';
import 'package:snack_ads/view/feed/feed_description.dart';
import 'package:video_player/video_player.dart';

class FeedView extends StatefulWidget {
  final FeedController feedProvider;
  const FeedView({super.key, required this.feedProvider});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  ShortForm temp =
      ShortForm(description: ' ', name: ' ', videoURL: ' ', likes: 0);

  @override
  void initState() {
    widget.feedProvider.loadVideos();

    super.initState();
  }

  @override
  void dispose() {
    widget.feedProvider.disposeAllController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        //  TODO: 새로고침시 새로운 영상 불러오기 추가
        onRefresh: () async {
          // setState(() {
          //   widget.feedProvider.loadVideos();
          // });
        },
        color: Colors.black,
        child: (widget.feedProvider.videoList.isNotEmpty)
            ? feedScreen(widget.feedProvider)
            : SafeArea(
                child: Stack(
                  children: [
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                    buttonUI(temp),
                  ],
                ),
              ),
      ),
    );
  }
}

Widget feedScreen(FeedController feedProvider) {
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );

  return PageView.builder(
    controller: pageController,
    itemCount: feedProvider.videoList.length,
    scrollDirection: Axis.vertical,
    onPageChanged: (index) {
      index = index % (feedProvider.videoList.length);
      feedProvider.changeVideo(index);
    },
    itemBuilder: (context, index) {
      index = index % (feedProvider.videoList.length);
      return videoScreen(feedProvider.videoList[index]);
    },
  );
}

Widget videoScreen(ShortForm video) {
  return SafeArea(
    child: Stack(
      children: [
        video.controller != null
            ? GestureDetector(
                onTap: () {
                  if (video.controller!.value.isPlaying) {
                    video.controller?.pause();
                  } else {
                    video.controller?.play();
                  }
                },
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: video.controller?.value.size.width ?? 0,
                      height: video.controller?.value.size.height ?? 0,
                      child: VideoPlayer(video.controller!),
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
        buttonUI(video),
      ],
    ),
  );
}

Widget buttonUI(ShortForm video) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //  report
            buttonDesign('    ', FontAwesomeIcons.ellipsisVertical, () {}),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FeedDescription(
              videoRestaurantName: video.name,
              videoDescription: video.description,
            ),
            FeedButtons(
              likes: video.likes,
            ),
          ],
        ),
      ],
    ),
  );
}
