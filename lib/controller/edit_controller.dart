import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:snack_ads/model/app_user.dart';

class EditController extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  // TextEditingControllers
  final TextEditingController nameController =
      TextEditingController(text: AppUser().name);
  final TextEditingController nicknameController =
      TextEditingController(text: AppUser().nickname);
  final TextEditingController phoneController =
      TextEditingController(text: AppUser().phone ?? "");

  void editProfileInfo(Map<String, dynamic> data) {
    final userRef = _db.collection("users").doc(AppUser().uid);
    userRef
        .update(data)
        .then((value) => dev.log("Successfully Edit", name: "EditController"));

    AppUser().name = nameController.text;
    AppUser().nickname = nicknameController.text;
    AppUser().phone = phoneController.text == "" ? null : phoneController.text;

    notifyListeners();
  }

  void clearController() {
    nameController.text = AppUser().name!;
    nicknameController.text = AppUser().nickname!;
    phoneController.text = AppUser().phone ?? "";

    notifyListeners();
  }
}
