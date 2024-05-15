class AppUser {
  String? uid;
  String? name;
  String? nickname;
  String? photoURL;
  String? email;
  String? phone;
  String? position;
  List<String> uploadedShortForms = [];
  List<String> likedShortForms = [];

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
    position = data['position'];
    uploadedShortForms = data['uploadedShortForms'];
    likedShortForms = data['likedShortForms'];
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'nickname': nickname,
      'photoURL': photoURL,
      'email': email,
      'phone': phone,
      'position': position,
      'uploadedShortForms': uploadedShortForms,
      'likedShortForms': likedShortForms,
    };
  }
}
