import 'package:snack_ads/model/shortform.dart';

class AppUser {
  String? uid;
  String? name;
  String? nickname;
  String? photoURL;
  String? email;
  String? phone;
  List<ShortForm> bookmarkList = [];

  // User({
  //   this.uid,
  //   this.name,
  //   this.nickname,
  //   this.photoURL,
  //   this.email,
  //   this.phone,
  //   this.bookmarkList = const [],
  // });

  // private internal constructor
  AppUser._internal();
  // single instance, initializes immediately
  static final AppUser _instance = AppUser._internal();
  // public factory method to access single instance
  factory AppUser() {
    return _instance;
  }

  void init(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    nickname = data['nickname'];
    photoURL = data['photoURL'];
    email = data['email'];
    phone = data['phone'];
    bookmarkList = data['bookmarkList'];
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'nickname': nickname,
      'photoURL': photoURL,
      'email': email,
      'phone': phone,
      'bookmarkList': bookmarkList,
    };
  }
}
