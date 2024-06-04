import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:snack_ads/controller/map/location_service.dart';
import 'package:snack_ads/model/restaurant.dart';

class LocalService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var json = {};
  var restaurantInfo = {};

  bool haveKakaoInfo = false;
  bool isLoading = false;

  String restaurantName = '';
  // double latitude = 0;
  // double longitude = 0;

  List<dynamic> searchResult = [];

  Future<void> checkRestaurantIsValid(Map<String, dynamic> restaurant) async {
    final String restaurantId = restaurant['id'];

    final DocumentSnapshot snapshot =
        await _firestore.collection('restaurants').doc(restaurantId).get();

    if (snapshot.exists) {
      log("Restaurant already exists in Firestore.", name: "Check Restaurant");
    } else {
      log("Restaurant does not exist in Firestore. Creating new document.",
          name: "Check Restaurant");
      Restaurant newRestaurant = Restaurant.fromMap(restaurant);
      newRestaurant = await getMoreInfos(restaurantId, newRestaurant);

      log(newRestaurant.toMap().toString(), name: "New Restaurant");

      await _firestore
          .collection("restaurants")
          .doc(restaurantId)
          .set(newRestaurant.toMap());
    }

    // restaurantRef.get().then((documentSnapshot) async {
    //   if (documentSnapshot.exists) {
    //     log("Restaurant already exists in Firestore.");
    //     log(documentSnapshot.data().toString());
    //   } else {
    //     log("Restaurant does not exist in Firestore. Creating new document.");
    //     Restaurant newRestaurant = Restaurant.fromMap(restaurant);
    //     newRestaurant = await getMoreInfos(restaurantId, newRestaurant);
    //     log(newRestaurant.toMap().toString(), name: "New Restaurant");

    //     final DocumentReference restaurantRef =
    //         _firestore.collection('restaurants').doc(restaurantId);
    //     await restaurantRef.set(newRestaurant.toMap());
    //   }
    // });
  }

  Future<Restaurant> getMoreInfos(String id, Restaurant restaurant) async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://place.map.kakao.com/main/v/$id"),
      );
      if (response.statusCode == 200) {
        json = jsonDecode(response.body);
        String imageurl = json['basicInfo']['mainphotourl'];
        List<dynamic> timeList =
            json['basicInfo']['openHour']['periodList'][0]["timeList"];

        restaurant.imageurl = imageurl;
        restaurant.timeList = timeList;

        return restaurant;
      }
      notifyListeners();
    } catch (error) {
      log(error.toString());
      return restaurant;
    }
    return restaurant;
  }

  Future<void> kakaoLocalSearchKeyword(String keyword) async {
    isLoading = true;
    notifyListeners();

    Position position = await LocationService().getCurrentLocation();
    double longitude = position.longitude; // x
    double latitude = position.latitude; // y
    log("latitude: $latitude, longitude: $longitude", name: "Your Location");

    restaurantInfo = {};
    try {
      http.Response response = await http.get(
        Uri.parse(
            "https://dapi.kakao.com/v2/local/search/keyword.json?x=$longitude&y=$latitude&radius=10000&query=$keyword&size=10&category_group_code=FD6,CE7"),
        headers: {
          // 임시입니다
          "Authorization": "KakaoAK 4d056234a214748603ae4c444eae0c5d",
        },
      );
      if (response.statusCode == 200) {
        haveKakaoInfo = true;
        json = jsonDecode(response.body);
        List<dynamic> doc = json['documents'];
        if (doc.isEmpty) {
          print("아쉽게도 위치정보를 제공하지 않는 가게입니다..");
        }
        // else {
        //   // restaurantInfo = doc[0];
        //   // restaurantName = keyword;
        //   // latitude = double.parse(restaurantInfo['y']);
        //   // longitude = double.parse(restaurantInfo['x']);
        //   // print("latitude: $latitude, longitude: $longitude");
        // }
        searchResult = doc;
        isLoading = false;
        notifyListeners();

        log(searchResult.length.toString(), name: "Search Result Length");
      }

      notifyListeners();
    } catch (error) {
      log(error.toString());
    }
  }

  Future<Restaurant> loadRestaurant(String id) async {
    await _firestore.collection('restaurants').doc(id).get().then((value) {
      if (value.exists) {
        Map<String, dynamic> data = value.data()!;
        Restaurant restaurant = Restaurant.fromFirestore(data);
        // log(restaurant.toString(), name: "Load Restaurant");
        return restaurant;
      } else {
        // log("Restaurant not found in Firestore.", name: "Load Restaurant");
        return Restaurant.defaultRestaurant();
      }
    });
    throw {
      log("error: Restaurant not found in Firestore."),
    };
  }

  Future<Restaurant> getRestaurant(String id) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('restaurants').doc(id).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      Restaurant restaurant = Restaurant.fromFirestore(data);
      log(restaurant.toString(), name: "Load Restaurant");
      return restaurant;
    } else {
      log("Restaurant not found in Firestore.", name: "Load Restaurant");
      return Restaurant.defaultRestaurant();
    }
    // .then((value) {
    //   if (value.exists) {
    //     Map<String, dynamic> data = value.data()!;
    //     Restaurant restaurant = Restaurant.fromFirestore(data);
    //     log(restaurant.toString(), name: "Load Restaurant");
    //     return restaurant;
    //   } else {
    //     log("Restaurant not found in Firestore.", name: "Load Restaurant");
    //     return Restaurant.defaultRestaurant();
    //   }
    // });
  }
}
