import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late NaverMapController mapController;
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  // String? _currentAddress;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition(); // 위젯 초기화 시 현재 위치를 가져오는 함수 호출
  }

  // 위치 권한을 확인하고 요청하는 함수
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스가 활성화되었는지 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }

    // 위치 권한을 확인하고 필요 시 요청
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }

    // 영구적으로 거부된 경우 처리
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    return true;
  }

  // 현재 위치를 가져오는 함수
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;

    // 현재 위치를 가져와서 _currentPosition에 저장하고 주소 변환 함수 호출
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      // _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

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

  // 네이버 맵 위젯을 반환하는 함수
  Widget _naverMapSection() {
    // 현재 위치 정보가 없으면 로딩 스피너를 표시
    if (_currentPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // 네이버 맵을 생성하여 반환
    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          // 현재 위치를 초기 카메라 위치로 설정
          target:
              NLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 17,
          bearing: 0,
          tilt: 0,
        ),
        indoorEnable: true, // 실내 맵 사용 가능 여부 설정
        locationButtonEnable: true, // 위치 버튼 표시 여부 설정
        consumeSymbolTapEvents: false, // 심볼 탭 이벤트 소비 여부 설정
      ),
      onMapReady: (controller) async {
        // 지도 준비 완료 시 호출되는 콜백 함수
        mapController = controller;
        mapControllerCompleter
            .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
        log("onMapReady", name: "onMapReady");
      },
    );
  }
}
