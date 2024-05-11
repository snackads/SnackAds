import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snack_ads/model/shortform.dart';
import 'package:video_player/video_player.dart';
import 'dart:developer' as dev;

class FeedController extends ChangeNotifier {
  List<ShortForm> videoList = [];
  VideoPlayerController? controller;
  int documentsLimit = 5; // 한 번에 로드할 문서 수
  DocumentSnapshot? last;
  QuerySnapshot? querySnapshot;

  // FeedController() {
  //   loadVideos();
  // }

  void loadVideos() async {
    try {
      await getNewVideoList(last).then((value) {
        changeVideo(0);
        notifyListeners();
      });
    } catch (e) {
      videoList.clear();
    }
  }

  Future<void> getNewVideoList(DocumentSnapshot? lastDocument) async {
    //  TODO: 추후 영상 가져오는 알고리즘 적용, query order: 위치 > 최신 > 좋아요

    if (lastDocument == null) {
      // 첫 페이지 로드
      querySnapshot = await FirebaseFirestore.instance
          .collection("shortFormVideos")
          .limit(documentsLimit)
          .get();
    } else {
      // 이전에 로드된 마지막 문서 이후의 데이터 로드
      querySnapshot = await FirebaseFirestore.instance
          .collection("shortFormVideos")
          .startAfterDocument(lastDocument)
          .limit(documentsLimit)
          .get();
    }

    // 새로운 데이터가 없는 경우에 대한 처리
    if (querySnapshot == null || querySnapshot!.docs.isEmpty) {
      notifyListeners();
      return;
    } else {
      last = querySnapshot!.docs[querySnapshot!.docs.length - 1];
    }

    for (var doc in querySnapshot!.docs) {
      ShortForm shortForm = ShortForm(
        uploadedAt: doc['uploadedAt'],
        restaurantName: doc['restaurantName'],
        restaurantAddress: doc['restaurantAddress'],
        restaurantRid: doc['restaurantRid'],
        videoURL: doc['videoURL'],
        likes: doc['likes'],
        shortFormSid: doc['shortFormSid'],
      );
      videoList.add(shortForm);
    }
    //dev.log('${videoList.length}');
    notifyListeners();
  }

  void changeVideo(index) async {
    //  현재 영상 재생
    if (videoList[index].controller == null) {
      await videoList[index].loadController();
      dev.log('$index 컨트롤러 load');
    }
    videoList[index].controller!.play();

    videoControllerValueControl(index - 1, 0);
    videoControllerValueControl(index + 1, 0);
    videoControllerValueControl(index - 1, 1);
    videoControllerValueControl(index + 1, 1);
    videoControllerValueControl(index - 2, 2);
    videoControllerValueControl(index + 2, 2);

    notifyListeners();
  }

  Future<void> videoControllerValueControl(int index, int state) async {
    if (index >= 0 && index <= videoList.length - 1) {
      //  load
      if (state == 0 && videoList[index].controller == null) {
        await videoList[index].loadController();
        dev.log('$index 컨트롤러 load');
      }

      // pause
      else if (state == 1 &&
          videoList[index].controller != null &&
          videoList[index].controller!.value.isPlaying) {
        videoList[index].controller!.pause();
        dev.log('$index 컨트롤러 pause');
      }

      //  dispose
      else if (state == 2 &&
          videoList[index].controller != null &&
          videoList[index].controller!.value.isInitialized) {
        videoList[index].controller!.dispose();
        videoList[index].controller = null;
        dev.log('$index 컨트롤러 dispose');
      }
    }
    notifyListeners();
  }

  //  페이지를 나갔다 와도 기존 영상 리스트는 유지
  void disposeAllController() {
    for (var d in videoList) {
      if (d.controller != null) {
        d.controller?.pause();
        d.controller?.dispose();
        d.controller = null;
      }
    }
  }
}
