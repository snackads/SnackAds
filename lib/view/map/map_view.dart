import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late NaverMapController mapController;
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF343945),
      body: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: mapSize.height,
              height: MediaQuery.of(context).size.height,
              // color: Colors.greenAccent,
              child: _naverMapSection())),
    );
  }

  Widget _naverMapSection() => NaverMap(
        options: const NaverMapViewOptions(
            // initialCameraPosition: NCameraPosition(
            //     target: NLatLng(latitude, longitude),
            //     zoom: 10,
            //     bearing: 0,
            //     tilt: 0),
            indoorEnable: true, // 실내 맵 사용 가능 여부 설정
            locationButtonEnable: true, // 위치 버튼 표시 여부 설정
            consumeSymbolTapEvents: false), // 심볼 탭 이벤트 소비 여부 설정

        onMapReady: (controller) async {
          // 지도 준비 완료 시 호출되는 콜백 함수
          mapController = controller;
          mapControllerCompleter
              .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
          log("onMapReady", name: "onMapReady");
        },
      );
// 출처: https://nompangbox.tistory.com/26 [놈팽이개발로그:티스토리]
}
