import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snack_ads/model/restaurant.dart';

class RestaurantController extends ChangeNotifier {
  final db = FirebaseFirestore.instance;

  Restaurant restaurant = Restaurant.defaultRestaurant();

  Restaurant loadRestaurant(String rid) {
    db.collection('restaurants').doc(rid).get().then((value) {
      if (value.exists) {
        Map<String, dynamic> data = value.data()!;
        restaurant = Restaurant.fromMap(data);
      }
      log(restaurant.toMap().toString(), name: "RestaurantController");
      return restaurant;
    });

    return restaurant;
  }
}
