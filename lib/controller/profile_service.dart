import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snack_ads/model/app_user.dart';
import 'package:snack_ads/model/restaurant.dart';
import 'package:snack_ads/model/shortform.dart';

class ProfileService extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  bool isUploaded = true;

  List<ShortForm> uploadedVideos = List.empty(growable: true);
  List<ShortForm> likedVideos = List.empty(growable: true);

  void setScreen({required bool isUploaded}) {
    this.isUploaded = isUploaded;
    notifyListeners();
  }

  Future<void> loadUploadedVideoList() async {
    List<dynamic> uploadedVideoIds = await loadLikedVideoID();
    List<ShortForm> uploadedShortForms = await loadShortForms(uploadedVideoIds);

    uploadedVideos = uploadedShortForms;

    notifyListeners();
  }

  Future<List<dynamic>> loadUploadedVideoID() async {
    String uid = AppUser().uid!;
    List<dynamic> uploadedVideoIds = [];

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(uid).get();

    if (snapshot.exists) {
      uploadedVideoIds = snapshot.get('uploadedShortForms');
      log("Uploaded videos: $uploadedVideoIds", name: "Profile Service");
    } else {
      log("User does not exist in Firestore.", name: "Profile Service");
    }

    notifyListeners();
    return uploadedVideoIds;
  }

  Future<void> loadLikedVideoList() async {
    List<dynamic> likedVideoIds = await loadLikedVideoID();
    List<ShortForm> likedShortForms = await loadShortForms(likedVideoIds);

    likedVideos = likedShortForms;

    notifyListeners();
  }

  Future<List<dynamic>> loadLikedVideoID() async {
    String uid = AppUser().uid!;
    List<dynamic> likedVideoIds = [];

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(uid).get();

    if (snapshot.exists) {
      likedVideoIds = snapshot.get('likedShortForms');
      log("Liked videos: $likedVideos", name: "Profile Service");
    } else {
      log("User does not exist in Firestore.", name: "Profile Service");
    }

    notifyListeners();
    return likedVideoIds;
  }

  Future<List<ShortForm>> loadShortForms(List<dynamic> idsList) async {
    List<ShortForm> shortForms = [];

    for (String id in idsList) {
      // log("ShortForm ID: $id", name: "Profile Service");
      DocumentSnapshot snapshot =
          await _firestore.collection('shortFormVideos').doc(id).get();

      if (snapshot.exists) {
        // log(snapshot.data().toString());
        ShortForm shortForm =
            ShortForm.fromMap(snapshot.data()! as Map<String, dynamic>);
        shortForms.add(shortForm);
      } else {
        log("ShortForm does not exist in Firestore.", name: "Profile Service");
      }
    }

    notifyListeners();
    log(shortForms.toString(), name: "Profile Service");
    return shortForms;
  }
}
