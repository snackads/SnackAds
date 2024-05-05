import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class RegisterController extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  // Firestore에 사용자 정보 추가하기
  void addUserInfoToFirestore(String uid, Map<String, dynamic> userInfo) {
    _db.collection("users").doc(uid).set(userInfo).then((value) {
      dev.log("User Info Added", name: 'addUserInfoToFirestore');
    }).catchError((error) {
      dev.log("Failed to add user: $error", name: 'addUserInfoToFirestore');
    });
  }

  // TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(text: "");
}
