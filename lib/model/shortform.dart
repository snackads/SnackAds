import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class ShortForm {
  Timestamp uploadedAt;
  String restaurantName;
  String restaurantAddress;
  String restaurantRid;
  String videoURL;
  String videoVid;
  String shortFormSid;
  int likes;

  VideoPlayerController? controller;

  ShortForm({
    required this.uploadedAt,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.restaurantRid,
    required this.videoURL,
    required this.videoVid,
    required this.shortFormSid,
    required this.likes,
  });

  Future<Null> loadController() async {
    controller = VideoPlayerController.networkUrl(Uri.parse(videoURL));
    await controller?.initialize();
    controller?.setLooping(true);
  }
}
