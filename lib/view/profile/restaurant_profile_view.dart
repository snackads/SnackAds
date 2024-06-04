import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/map/local_service.dart';
import 'package:snack_ads/model/restaurant.dart';

class RestaurantProfileView extends StatelessWidget {
  String restaurantId;
  RestaurantProfileView({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<LocalService>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFf8f8fa),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40),
          child: FutureBuilder(
              future: service.getRestaurant(restaurantId),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return const Center(child: Text("로딩 중"));
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                } else {
                  Restaurant data = snapshot.data!;
                  log(data.toMap().toString(), name: "Profile View");

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.place_name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children:
                            data.tag_list.map((tag) => tagBox(tag)).toList(),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.access_time),
                                  const Text(" 영업시간 "),
                                  data.timeList.isEmpty
                                      ? const Text("정보 없음")
                                      : Text(
                                          data.timeList[0]['timeSE'].toString(),
                                        ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.phone),
                                  const Text(" 전화번호 "),
                                  Text(data.phone),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.location_pin),
                          const Text("주소 "),
                          Text(data.address_name),
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        height: 200,
                        width: double.infinity,
                        child: const Center(child: Text("여기에 네이버지도 들어가야함")),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Icon(Icons.movie_creation_outlined),
                          Text("관련 게시물"),
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        height: 200,
                        width: double.infinity,
                        child: const Center(child: Text("여기에 게시물 리스트 들어가야함")),
                      ),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}

Widget tagBox(String tag) {
  return Container(
    padding: const EdgeInsets.all(5),
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(tag),
  );
}
