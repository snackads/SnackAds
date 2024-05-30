import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snack_ads/model/shortform.dart';
import 'package:video_player/video_player.dart';

import 'dart:developer' as dev;

class SharedFeedControllor with ChangeNotifier {
  ShortForm video = ShortForm.defaultShortForm();
  VideoPlayerController? controller;

  void loadVideo(String videoSid) async {
    try {
      await getNewVideo(videoSid).then((value) {
        loadAndPlayVideo();
        notifyListeners();
      });
    } catch (e) {
      dev.log('에러 발생');
    }
  }

  Future<void> getNewVideo(String videoSid) async {
    // 첫 페이지 로드
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("shortFormVideos")
        .doc(videoSid)
        .get();

    ShortForm shortForm = ShortForm(
      uploadedAt: doc['uploadedAt'],
      restaurantName: doc['restaurantName'],
      restaurantAddress: doc['restaurantAddress'],
      restaurantRid: doc['restaurantRid'],
      videoURL: doc['videoURL'],
      likes: doc['likes'],
      shortFormSid: doc['shortFormSid'],
    );
    video = shortForm;

    notifyListeners();
  }

  void loadAndPlayVideo() async {
    //  현재 영상 재생
    if (video.controller == null) {
      await video.loadController();
      video.controller!.play();
      notifyListeners();

      dev.log('공유 영상 컨트롤러 load');
    }
  }

  void disposeVideoController() {
    if (video.controller != null) {
      video.controller!.pause();
      video.controller!.dispose();
      video.controller = null;
    }
    video = ShortForm.defaultShortForm();
  }
}
