import 'package:video_player/video_player.dart';

class ShortForm {
  String name;
  String description;
  String videoURL;
  String videoVid;
  int likes;

  VideoPlayerController? controller;

  ShortForm({
    required this.name,
    required this.description,
    required this.videoURL,
    required this.videoVid,
    required this.likes,
  });

  Future<Null> loadController() async {
    controller = VideoPlayerController.networkUrl(Uri.parse(videoURL));
    await controller?.initialize();
    controller?.setLooping(true);
  }
}
