import 'package:snack_ads/model/shortform.dart';

class User {
  String? uid;
  String name;
  String nickname;
  String? email;
  String? phone;
  List<ShortForm> likedShortForms = [];

  User({
    this.uid,
    required this.name,
    required this.nickname,
    required this.email,
    this.phone,
  });

  factory User.fromFirestore(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      name: data['name'],
      nickname: data['nickname'],
      email: data['email'],
      phone: data['phone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'nickname': nickname,
      'email': email,
      'phone': phone,
    };
  }
}
