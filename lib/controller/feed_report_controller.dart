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
      int reportedCount = doc['reportedCount'] ?? 0;

      dev.log('이미 동일한 비디오가 존재합니다. 신고 횟수가 누적됩니다.');

      //  신고 횟수가 10회 이상 누적된 경우 삭제
      if (reportedCount >= 10) {
        await videoRef.delete(); // 파일 삭제
        dev.log('신고 횟수가 10회 이상입니다. 영상을 삭제합니다.');
        return;
      }
    } else {
      videoRef.set({
        'restaurantName': video.restaurantName,
        'restaurantAddress': video.restaurantAddress,
        'videoURL': video.videoURL,
        'videoVid': video.videoVid,
        'shortFormSid': video.shortFormSid,
        'reportedCount': 1,
      }).then((value) {
        dev.log('영상이 신고되어 DB에 기록되었습니다.');
      }).catchError((error) {
        dev.log('업데이트 중 에러 발생: $error');
      });
    }
  }
}
