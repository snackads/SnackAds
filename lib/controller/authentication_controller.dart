import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as dev;

class AuthenticationController with ChangeNotifier {
  User? _user;
  final _auth = FirebaseAuth.instance;

  void Function()? isUserLoggedIn;
  void Function()? isUserLoggedOut;

  AuthenticationController() {
    dev.log("Checking User Changes", name: 'AuthenticationController');
    FirebaseAuth.instance.userChanges().listen((User? user) {
      _user = user;
      if (_user != null) {
        dev.log("User Logged In", name: 'AuthenticationController');
        if (isUserLoggedIn != null) {
          isUserLoggedIn!();
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
}
