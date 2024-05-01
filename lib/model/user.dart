import 'package:snack_ads/model/shortform.dart';

class User {
  String name;
  String nickName;
  String email;
  int? phone;
  List<ShortForm> likedShortForms = [];

  User({
    required this.name,
    required this.nickName,
    required this.email,
    this.phone,
  });
}
