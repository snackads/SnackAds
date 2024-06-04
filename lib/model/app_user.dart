class AppUser {
  String? uid;
  String? name;
  String? nickname;
  String? photoURL;
  String? email;
  String? phone;
  List<String> uploadedShortForms = List.empty(growable: true);
  List<String> likedShortForms = List.empty(growable: true);

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
      'uploadedShortForms': uploadedShortForms,
      'likedShortForms': likedShortForms,
    };
  }
}
