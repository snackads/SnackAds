import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:snack_ads/model/shortform.dart';
import 'dart:developer' as dev;

class FeedReportController extends ChangeNotifier {
  void reportVideoToDB(ShortForm video) async {
    DocumentReference videoRef = FirebaseFirestore.instance
        .collection('reportedVideos')
        .doc(video.videoVid);

    DocumentSnapshot doc = await videoRef.get();
    if (doc.exists) {
      // 이미 동일한 videoVid를 가진 비디오가 존재하는 경우
      videoRef.update({'reportedCount': FieldValue.increment(1)});
      dev.log('이미 동일한 비디오가 존재합니다. 신고 횟수가 누적됩니다.');
    } else {
      videoRef.set({
        'name': video.name,
        'description': video.description,
        'videoURL': video.videoURL,
        'videoVid': video.videoVid,
        'reportedCount': 1,
      }).then((value) {
        dev.log('영상이 신고되어 DB에 기록되었습니다.');
      }).catchError((error) {
        dev.log('업데이트 중 에러 발생: $error');
      });
    }
  }
}
