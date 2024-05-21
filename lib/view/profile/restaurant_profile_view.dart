import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantProfileView extends StatelessWidget {
  const RestaurantProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    String mockName = "금수저삼겹679양덕점";
    String mockAddress = "경북 포항시 북구 천마로 78";
    List<String> mockTags = ["포항", "고기", "가성비", "한식"];
    String mockDescription = "포항에서 가장 맛있는 삼겹살집입니다. 가격도 저렴하고 양도 푸짐합니다.";
    String siteURL = "https://place.map.kakao.com/1956782003";
    String phoneNumber = "054-232-5790";
    String openTime = "매일 15:00 ~ 23:00";

    return Scaffold(
      backgroundColor: const Color(0xFFf8f8fa),
      appBar: AppBar(
        title: Text(mockName),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFf8f8fa),
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: mockTags.map((tag) => tagBox(tag)).toList(),
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
                          const Text("영업시간 "),
                          Text(openTime),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.phone),
                          const Text("전화번호 "),
                          Text(phoneNumber),
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
                  Text(mockAddress),
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
          ),
        ),
      ),
    );
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
}
