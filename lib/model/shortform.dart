import 'package:video_player/video_player.dart';

class ShortForm {
  String name;
  String description;
  String videoURL;
  int likes;

  VideoPlayerController? controller;

  ShortForm({
    required this.name,
    required this.description,
    required this.videoURL,
    required this.likes,
  });

  Future<Null> loadController() async {
    controller = VideoPlayerController.networkUrl(Uri.parse(videoURL));
    await controller?.initialize();
    controller?.setLooping(true);
  }
}
