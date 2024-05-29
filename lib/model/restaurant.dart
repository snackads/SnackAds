class Restaurant {
  String rid;
  String name;
  String description;
  List<String> tagList;
  String phone;
  String address;
  String siteURL;
  String imageURL;
  double? latitude;
  double? longitude;

  Restaurant({
    required this.rid,
    required this.name,
    required this.description,
    required this.tagList,
    required this.phone,
    required this.address,
    required this.siteURL,
    required this.imageURL,
    this.latitude,
    this.longitude,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      rid: map['rid'],
      name: map['name'],
      description: map['description'],
      tagList: List<String>.from(map['tagList']),
      phone: map['phone'],
      address: map['address'],
      siteURL: map['siteURL'],
      imageURL: map['imageURL'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  factory Restaurant.defaultRestaurant() {
    return Restaurant(
      rid: '',
      name: '',
      description: '',
      tagList: [],
      phone: '',
      address: '',
      siteURL: '',
      imageURL: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rid': rid,
      'name': name,
      'description': description,
      'tagList': tagList,
      'phone': phone,
      'address': address,
      'siteURL': siteURL,
      'imageURL': imageURL,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
