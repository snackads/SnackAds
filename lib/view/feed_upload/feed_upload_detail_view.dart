import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:go_router/go_router.dart';
import 'package:snack_ads/controller/feed_upload_controller.dart';
import 'dart:developer' as dev;
import 'dart:async';

import 'package:snack_ads/model/restaurant.dart';

class FeedUploadDetailView extends StatefulWidget {
  final FeedUploadController feedUploadController;
  const FeedUploadDetailView({super.key, required this.feedUploadController});

  @override
  State<FeedUploadDetailView> createState() => _FeedUploadDetailViewState();
}

class _FeedUploadDetailViewState extends State<FeedUploadDetailView> {
  late NaverMapController mapController;
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  Restaurant selectedRestaurant = Restaurant(
      rid: 'rid',
      name: 'name',
      description: 'description',
      tagList: ['tagList'],
      phone: 'phone',
      address: 'address',
      siteURL: 'siteURL',
      imageURL: 'imageURL');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('가게 위치 설정'),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  TODO: 네이버 지도로 가게 위치 선택해서 selectedRestaurant에 넣어주세요.
              Expanded(child: naverMapSection()),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: designedText('뒤로가기'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (selectedRestaurant.rid.isNotEmpty) {
                          // 로딩 인디케이터
                          // showDialog(
                          //   context: context,
                          //   barrierDismissible:
                          //       false, // 다이얼로그 외부를 터치해도 닫히지 않도록 설정
                          //   builder: (BuildContext context) {
                          //     return const Center(
                          //       child: CircularProgressIndicator(
                          //         color: Colors.black,
                          //       ), // 인디케이터를 표시
                          //     );
                          //   },
                          // );
                          //  TODO: 임시 함수 추후에 삭제
                          widget.feedUploadController
                              .updateRestaurantData(selectedRestaurant);
                          widget.feedUploadController
                              .uploadNewShortFormToDatabase(selectedRestaurant)
                              .then((value) {
                            // 로딩 인디케이터 삭제
                            //Navigator.of(context).pop();
                            context.go('/main');
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('영상이 성공적으로 업로드되었습니다 :)'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('영상 업로드 중 문제가 발생하였습니다 :('),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          });
                        } else {
                          dev.log('필수 정보가 미입력되었습니다.');
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: designedText('저장하기'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget naverMapSection() => NaverMap(
        options: const NaverMapViewOptions(
          // initialCameraPosition: NCameraPosition(
          //     target: NLatLng(latitude, longitude),
          //     zoom: 10,
          //     bearing: 0,
          //     tilt: 0),
          indoorEnable: true,
          locationButtonEnable: true,
          consumeSymbolTapEvents: false,
        ),
        onMapReady: (controller) async {
          // 지도 준비 완료 시 호출되는 콜백 함수
          mapController = controller;
          mapControllerCompleter
              .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
        },
      );
}

Widget designedText(String text) {
  return Text(
    text,
    style: const TextStyle(color: Colors.white, fontSize: 20),
  );
}

Widget TempButton(
    Restaurant selectedRestaurant, FeedUploadController feedUploadController) {
  return ElevatedButton(
      onPressed: () {
        feedUploadController.updateRestaurantData(selectedRestaurant);
      },
      child: const Text('update'));
}
