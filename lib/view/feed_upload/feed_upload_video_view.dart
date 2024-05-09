import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:snack_ads/controller/feed_upload_controller.dart';
import 'package:video_player/video_player.dart';

class FeedUploadVideoView extends StatefulWidget {
  final FeedUploadController feedUploadController;
  const FeedUploadVideoView({super.key, required this.feedUploadController});

  @override
  State<FeedUploadVideoView> createState() => _FeedUploadVideoViewState();
}

class _FeedUploadVideoViewState extends State<FeedUploadVideoView> {
  bool _isVisible = false;

  @override
  void initState() {
    widget.feedUploadController.setVideo();
    super.initState();
  }

  @override
  void dispose() {
    widget.feedUploadController.disposeController();
    super.dispose();
  }

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: (widget.feedUploadController.video != null)
          ? videoScreen(widget.feedUploadController.videoController!,
              _isVisible, _togglePlayAndPauseVisibility, context)
          : const SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

Widget videoScreen(
  VideoPlayerController videoController,
  bool isVisible,
  Function togglePlayAndPauseVisibility,
  BuildContext context,
) {
  return SafeArea(
    child: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  togglePlayAndPauseVisibility();
                  if (videoController.value.isPlaying) {
                    videoController.pause();
                  } else {
                    videoController.play();
                  }
                },
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: videoController.value.size.width,
                      height: videoController.value.size.height,
                      child: VideoPlayer(videoController),
                    ),
                  ),
                ),
              ),
              Center(
                child: AnimatedOpacity(
                  opacity: isVisible ? 1.0 : 0.0,
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
                        (videoController.value.isPlaying)
                            ? FontAwesomeIcons.circlePlay
                            : FontAwesomeIcons.circlePause,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          color: Colors.black,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: designedText('이전'),
            ),
            TextButton(
              onPressed: () {
                //  TODO: 영상 ShortForm Model 생성 및 파베 업로드 구현
              },
              child: designedText('다음'),
            ),
          ]),
        )
      ],
    ),
  );
}

Widget designedText(String text) {
  return Text(
    text,
    style: const TextStyle(color: Colors.white, fontSize: 20),
  );
}
