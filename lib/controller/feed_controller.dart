import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snack_ads/model/shortform.dart';
import 'package:video_player/video_player.dart';

class FeedController extends ChangeNotifier {
  List<ShortForm> videoList = [];
  VideoPlayerController? controller;
  int prevVideo = 0;

  // FeedController() {
  //   loadVideos();
  // }

  void loadVideos() async {
    try {
      List<ShortForm> newVideoList = await getVideoList();
      videoList.clear();
      videoList.addAll(newVideoList);
      loadVideoController(0);
    } catch (e) {
      videoList.clear();
    }
  }

  Future<List<ShortForm>> getVideoList() async {
    List<ShortForm> videoList = [];

    //  TODO: 추후 영상 가져오는 알고리즘 적용
    var data = await FirebaseFirestore.instance.collection("Videos").get();
    for (var doc in data.docs) {
      ShortForm shortForm = ShortForm(
        name: doc['name'],
        description: doc['description'],
        videoURL: doc['videoURL'],
        likes: doc['likes'],
      );
      videoList.add(shortForm);
    }
    return videoList;
  }

  void changeVideo(index) async {
    if (videoList[index].controller == null) {
      await videoList[index].loadController();
    }
    videoList[index].controller!.play();
    //videoListprevVideo].controller.removeListener(() {});

    if (videoList[prevVideo].controller != null) {
      videoList[prevVideo].controller!.pause();
    }

    prevVideo = index;
    notifyListeners();
  }

  void loadVideoController(int index) async {
    if (videoList.length > index) {
      await videoList[index].loadController();
      videoList[index].controller?.play();
      notifyListeners();
    }
  }

  void disposeAllController() {
    for (var d in videoList) {
      d.controller?.pause();
      d.controller?.dispose();
    }
    videoList.clear();
  }
}
