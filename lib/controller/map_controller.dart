import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class MapProvider extends ChangeNotifier {
  var json = {}; // Kakao API 응답 데이터를 저장할 변수
  var restaurantInfo = {}; // 특정 식당의 정보를 저장할 변수

  bool haveKakaoInfo = false; // Kakao API 응답 여부를 저장할 변수

  String restaurantName = ''; // 식당 이름
  double latitude = 0; // 식당의 위도
  double longitude = 0; // 식당의 경도

  ValueKey mapKey = ValueKey(DateTime.now()); // Naver Map을 갱신하기 위한 키

  String placeImageUrl = ''; // 식당 이미지 URL

  List<Map<String, dynamic>> restaurants = []; // Firestore에서 가져온 식당 정보를 저장할 리스트

  Map<String, dynamic>? selectedRestaurant; // 선택된 식당 정보를 저장할 변수

  // Naver Map을 초기화하는 메서드
  void triggerInit() {
    mapKey = ValueKey(DateTime.now());
    notifyListeners();
  }

  // Kakao API를 사용하여 식당 이미지를 가져오는 메서드
  Future<void> getImageUrl(String placeId) async {
    final url = Uri.parse("https://place.map.kakao.com/main/v/$placeId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        json = jsonDecode(response.body);
        placeImageUrl = json['basicInfo']['mainphotourl'];
      } else {
        log('Failed to load image URL: ${response.statusCode}');
      }
    } catch (error) {
      log('Error fetching image URL: $error');
    }

    notifyListeners();
  }

  // Kakao API를 사용하여 키워드로 식당을 검색하는 메서드
  Future<void> kakaoLocalSearchKeyword(String keyword) async {
    final url = Uri.parse(
      "https://dapi.kakao.com/v2/local/search/keyword.json?x=129.388849&y=36.103255&radius=10000&query=$keyword&size=1&category_group_code=FD6,CE7",
    );

    const headers = {
      "Authorization":
          "KakaoAK a810dd38c7a8846d60b6ae5b24030da3", // 실제 키로 대체 필요
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        json = jsonDecode(response.body);
        final doc = json['documents'] as List<dynamic>;

        if (doc.isEmpty) {
          haveKakaoInfo = false;
          log("No location information available for the restaurant.");
        } else {
          haveKakaoInfo = true;
          restaurantInfo = doc[0];
          restaurantName = keyword;
          latitude = double.parse(restaurantInfo['y']);
          longitude = double.parse(restaurantInfo['x']);
          log("Latitude: $latitude, Longitude: $longitude");
        }
      } else {
        log('Failed to fetch search results: ${response.statusCode}');
      }
    } catch (error) {
      log('Error during keyword search: $error');
    }

    notifyListeners();
  }

  // Firestore에서 식당 정보를 가져오는 메서드
  Future<void> fetchRestaurantsFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('restaurants').get();

      restaurants = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return {
          'address_name': data['address_name'],
          'id': data['id'],
          'imageurl': data['imageurl'],
          'phone': data['phone'],
          'place_name': data['place_name'],
          'place_url': data['place_url'],
          'road_address_name': data['road_address_name'],
          'x': data['x'],
          'y': data['y']
          // 'address_name': data['address_name'],
          // 'address_name': data['address_name'],
          // 'address_name': data['address_name'],
          // 'address_name': data['address_name']
        };
      }).toList();

      log("Fetched ${restaurants.length} restaurants from Firestore.");
      notifyListeners();
    } catch (error) {
      log('Error fetching restaurants from Firestore: $error');
    }
  }

  // 특정 식당의 세부 정보를 Firestore에서 가져오는 메서드
  Future<void> fetchRestaurantDetails(String restaurantId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(restaurantId)
          .get();

      selectedRestaurant = doc.data() as Map<String, dynamic>?;

      if (selectedRestaurant != null) {
        log("Fetched details for restaurant ID $restaurantId.");
      } else {
        log("No details found for restaurant ID $restaurantId.");
      }

      notifyListeners();
    } catch (error) {
      log('Error fetching restaurant details: $error');
    }
  }

  // 모든 데이터를 초기화하는 메서드
  void clearAll() {
    json = {};
    restaurantInfo = {};
    restaurantName = '';
    placeImageUrl = '';
    latitude = 0;
    longitude = 0;
    restaurants = [];
    selectedRestaurant = null;
    notifyListeners();
  }
}
