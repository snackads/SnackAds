import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snack_ads/model/app_user.dart';
import 'package:snack_ads/model/restaurant.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'dart:developer' as dev;

class FeedUploadController extends ChangeNotifier {
  XFile? video;
  final ImagePicker picker = ImagePicker();
  VideoPlayerController? videoController;
  String videoURL = '';

  List<Restaurant> allRestaurantList = [];
  Restaurant restaurant = Restaurant(
    rid: '',
    name: '',
    description: '',
    tagList: [''],
    phone: '',
    address: '',
    siteURL: '',
    imageURL: '',
  );

  Future getVideo(ImageSource imageSource, BuildContext context) async {
    final XFile? pickedFile = await picker.pickVideo(source: imageSource);
    if (pickedFile != null) {
      videoController = VideoPlayerController.file(File(pickedFile.path))
        ..initialize().then((_) {
          final Duration duration = videoController!.value.duration;
          // 영상 길이가 1분을 초과하는지 확인
          if (duration.inSeconds > 60.1) {
            dev.log('경고 너무 김');
            showMessage(context, '영상은 1분을\n초과할 수 없습니다.');
          } else {
            video = XFile(pickedFile.path);
            dev.log('영상 선택 성공');
            videoController?.setLooping(true);
            context.push('/videoUpload');
          }
        });
    } else {
      dev.log('영상 선택 실패');
      showMessage(context, '영상 업로드가 취소되었습니다.');
    }

    notifyListeners();
  }

  void setVideo(BuildContext context) async {
    if (videoController == null) {
      context.pop();
    }
    videoController!.play();
  }

  void disposeController() {
    videoController?.pause();
    videoController?.dispose();
  }

  Future<void> getAllRestaurantList() async {
    dev.log('가져와아아아아');
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('restaurants').get();
      allRestaurantList = querySnapshot.docs.map((doc) {
        return Restaurant(
          rid: doc.id,
          name: doc['name'],
          description: doc['name'],
          tagList: List<String>.from(doc['tagList']),
          phone: doc['phone'],
          address: doc['address'],
          siteURL: doc['siteURL'],
          imageURL: doc['imageURL'],
        );
      }).toList();
    } catch (e) {
      dev.log('Error fetching restaurants: $e');
    }
    notifyListeners();
  }

  void updateRestaurantData(Restaurant selectedRestaurant) {
    dev.log(selectedRestaurant.name);
    restaurant = selectedRestaurant;
    notifyListeners();
  }

  void removeRestaurantData() {
    dev.log('지워!!!');
    restaurant.rid = '';
  }

  Future<bool> uploadNewVideoToDB(Restaurant restaurantTemp) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('shortFormVideos').doc();
      String documentId = documentReference.id;

      AppUser().uploadedShortForms.add(documentId);

      FirebaseFirestore.instance.collection("users").doc(AppUser().uid).update({
        'uploadedShortForms': FieldValue.arrayUnion([documentId])
      }).then((_) {
        dev.log('Document ID added to uploadedShortForms array');
      }).catchError((error) {
        dev.log('Error adding document ID: $error');
      });

      uploadVideoToStorage(documentId).then((value) {
        documentReference.set({
          'uploadedAt': Timestamp.now(),
          'restaurantName': restaurantTemp.name,
          'restaurantAddress': restaurantTemp.address,
          'restaurantRid': restaurantTemp.rid,
          'videoURL': videoURL,
          'shortFormSid': documentId,
          'likes': 0,
        });
      });
      dev.log('ShortForm video added to Firestore successfully.');
      return true;
    } catch (error) {
      dev.log('Error adding ShortForm video to Firestore: $error');
      return false;
    }
  }

  Future uploadVideoToStorage(String documentId) async {
    try {
      // Firebase Storage에 영상 업로드
      Reference storageReference =
          FirebaseStorage.instance.ref('shortFormVideos/$documentId');
      UploadTask uploadTask = storageReference.putFile(File(video!.path));

      // 업로드가 완료될 때까지 대기
      TaskSnapshot taskSnapshot = await uploadTask;

      // 업로드된 영상의 URL 가져오기
      videoURL = await taskSnapshot.ref.getDownloadURL();

      dev.log('Video uploaded to Storage and database successfully: $videoURL');
    } catch (error) {
      dev.log('Error uploading video: $error');
    }
  }
}

Future showMessage(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          child: const Text('확인'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
