import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:developer' as dev;

import 'package:snack_ads/model/app_user.dart';
import 'package:snack_ads/widget/snackbars/info_snackbar.dart';

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

  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      dev.log(e.toString());
      if (!context.mounted) return;
      infoSnackBar(context: context, msg: "로그인에 실패하였습니다.");
    }
  }

  // apple 로그인
  Future<void> signInWithApple({required BuildContext context}) async {
    //appstoreconnect에서 configuration 필요. 아래 링크 참고 바람.
    //https://velog.io/@s_soo100/Flutter-Firebase%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%9C-%EC%95%A0%ED%94%8C-%EB%A1%9C%EA%B7%B8%EC%9D%B8-Apple-Sign-in-With-Firebase
    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      await _auth.signInWithCredential(oauthCredential);
    } catch (err) {
      dev.log('err : $err');
      if (!context.mounted) return;
      infoSnackBar(context: context, msg: "로그인에 실패하였습니다.");
    }
  }

  // Google 로그인
  Future<void> signInWithGoogle({required BuildContext context}) async {
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
      if (!context.mounted) return;
      infoSnackBar(context: context, msg: "로그인에 실패하였습니다.");
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
