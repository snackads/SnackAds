class Restaurant {
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
}
