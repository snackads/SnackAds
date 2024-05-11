import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:snack_ads/model/shortform.dart';
import 'dart:developer' as dev;

class FeedReportController extends ChangeNotifier {
  void reportVideoToDB(ShortForm video) async {
    DocumentReference videoRef = FirebaseFirestore.instance
        .collection('reportedVideos')
        .doc(video.shortFormSid);

    DocumentSnapshot doc = await videoRef.get();
    if (doc.exists) {
      // 이미 동일한 videoVid를 가진 비디오가 존재하는 경우
      dev.log('이미 동일한 비디오가 존재합니다. 신고 횟수가 누적됩니다.');
      await videoRef
          .update({'reportedCount': FieldValue.increment(1)}).then((_) {
        // reportedCount 값 업데이트 후에 값을 가져와서 사용함
        int reportedCount = doc['reportedCount'] ?? 0;

        //  신고 횟수가 과다하게 누적된 경우 삭제
        if (reportedCount >= 3) {
          DocumentReference videoRef2 = FirebaseFirestore.instance
              .collection('shortFormVideos')
              .doc(video.shortFormSid);

          // Storage에서 영상 삭제
          Reference storageRef = FirebaseStorage.instance
              .ref()
              .child('shortFormVideos/${video.shortFormSid}');
          storageRef.delete(); // 파일 삭제

          // 파일 삭제
          videoRef.delete().then((_) => videoRef2.delete());
          dev.log('신고 횟수가 10회 이상입니다. 영상을 삭제합니다.');
        }
      });
    } else {
      videoRef.set({
        'restaurantName': video.restaurantName,
        'restaurantAddress': video.restaurantAddress,
        'videoURL': video.videoURL,
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
