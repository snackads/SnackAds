import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as dev;

import 'package:snack_ads/model/app_user.dart';

class AuthenticationController with ChangeNotifier {
  User? _user;
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  void Function()? isUserLoggedIn;
  void Function()? isUserLoggedOut;

  void Function()? moveToRegisterView;

  // Authentication Constructor
  AuthenticationController() {
    dev.log("Checking User Changes", name: 'AuthenticationController');
    FirebaseAuth.instance.userChanges().listen((User? user) {
      _user = user;
      if (_user != null) {
        dev.log("User Logged In", name: 'AuthenticationController');
        if (isUserLoggedIn != null) {
          isUserLoggedIn!();
          getUserInfoFromFirestore();
        }
      } else {
        dev.log("User Logged Out", name: 'AuthenticationController');
      }
      notifyListeners(); // 상태 변화를 알립니다.
    });
  }

  // Google 로그인
  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        _user = userCredential.user;
        dev.log(userCredential.user.toString(), name: 'Logged In User Info');
      }
    } catch (e) {
      dev.log(e.toString(), name: 'AuthenticationController.signInWithGoogle');
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
    if (isUserLoggedOut != null) {
      isUserLoggedOut!();
    }
    notifyListeners();
  }

  // 현재 사용자
  User? get currentUser => _auth.currentUser;

  // Firestore에서 사용자 정보 가져오기
  void getUserInfoFromFirestore() {
    _db.collection("users").doc(_user!.uid).get().then((doc) {
      if (doc.exists) {
        dev.log(doc.data().toString(), name: 'getUserInfoFromFirestore');
        AppUser().init(doc.data()!);
        dev.log(AppUser().toFirestore().toString(), name: "AppUser");
      } else {
        dev.log("No such document", name: 'getUserInfoFromFirestore');
        moveToRegisterView!();
      }
    }).catchError((error) {
      dev.log("Error getting document: $error",
          name: 'getUserInfoFromFirestore');
    });
  }
}
