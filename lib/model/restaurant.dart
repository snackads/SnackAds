// ignore_for_file: non_constant_identifier_names

class Restaurant {
  String id;
  String place_name;
  String address_name;
  String phone;
  String place_url;
  String road_address_name;
  String x;
  String y;
  List<dynamic> tag_list;
  String imageurl;
  List<dynamic> timeList;

  Restaurant({
    required this.id,
    required this.place_name,
    required this.address_name,
    required this.phone,
    required this.place_url,
    required this.road_address_name,
    required this.x,
    required this.y,
    required this.tag_list,
    this.imageurl = '',
    this.timeList = const [],
  });

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      place_name: map['place_name'],
      address_name: map['address_name'],
      phone: map['phone'],
      place_url: map['place_url'],
      road_address_name: map['road_address_name'],
      x: map['x'],
      y: map['y'],
      tag_list: map['category_name'].toString().split(' > '),
      // imageurl: map['imageurl'],
      // timeList: map['timeList'],
    );
  }

  factory Restaurant.fromFirestore(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      place_name: map['place_name'],
      address_name: map['address_name'],
      phone: map['phone'],
      place_url: map['place_url'],
      road_address_name: map['road_address_name'],
      x: map['x'],
      y: map['y'],
      tag_list: map['tag_list'],
      imageurl: map['imageurl'],
      timeList: map['timeList'],
    );
  }

  factory Restaurant.defaultRestaurant() {
    return Restaurant(
      id: '',
      place_name: '',
      address_name: '',
      phone: '',
      place_url: '',
      road_address_name: '',
      x: '',
      y: '',
      tag_list: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place_name': place_name,
      'address_name': address_name,
      'phone': phone,
      'place_url': place_url,
      'road_address_name': road_address_name,
      'x': x,
      'y': y,
      'tag_list': tag_list,
      'imageurl': imageurl,
      'timeList': timeList,
    };
  }
}
