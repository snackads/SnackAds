import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/map_controller.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late NaverMapController mapController;
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.fetchRestaurantsFromFirestore(); // Firestore에서 식당 정보 불러오기
  }

  // 위치 권한을 확인하는 메서드
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    return true;
  }

  // 현재 위치를 가져오는 메서드
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // 식당 정보 카드를 빌드하는 메서드
  // Widget _buildRestaurantCard(MapProvider mapProvider) {
  //   if (mapProvider.selectedRestaurant == null) {
  //     return SizedBox.shrink(); // 선택된 식당이 없는 경우 빈 공간 반환
  //   }

  //   final restaurant = mapProvider.selectedRestaurant!;
  //   return Positioned(
  //     bottom: 0,
  //     left: 0,
  //     right: 0,
  //     child: Card(
  //       margin: EdgeInsets.all(16.0),
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               restaurant['name'] ?? 'Unknown',
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //             SizedBox(height: 8),
  //             Text(
  //               'Address: ${restaurant['address'] ?? 'N/A'}',
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             Text(
  //               'Description: ${restaurant['description'] ?? 'N/A'}',
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             Text(
  //               'Phone: ${restaurant['phone'] ?? 'N/A'}',
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             Text(
  //               'Latitude: ${restaurant['latitude']}',
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             Text(
  //               'Longitude: ${restaurant['longitude']}',
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             Text(
  //               'Tags: ${(restaurant['tagList'] as List<dynamic>).join(', ')}',
  //               style: TextStyle(fontSize: 16),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);

    Widget _buildNaverMap() {
      if (_currentPosition == null) {
        return Center(child: CircularProgressIndicator()); // 현재 위치를 가져오는 중인 경우
      }

      return NaverMap(
        key: mapProvider.mapKey,
        options: NaverMapViewOptions(
          locationButtonEnable: true,
          initialCameraPosition: NCameraPosition(
            target: NLatLng(
                _currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 15,
          ),
        ),
        onMapReady: (controller) {
          mapControllerCompleter.complete(controller);
          mapController = controller;

          for (var restaurant in mapProvider.restaurants) {
            final marker = NMarker(
              id: restaurant['rid'], // 식별을 위해 rid 사용
              position:
                  NLatLng(restaurant['latitude'], restaurant['longitude']),
              caption: NOverlayCaption(text: restaurant['name']),

              // onTap: (NMarker marker, Map<String, int> iconSize) async {
              //   await mapProvider.fetchRestaurantDetails(restaurant['rid']);
              // },
            );

            controller.addOverlay(marker);
          }
        },
        onMapTapped: (NPoint point, NLatLng latLng) {
          mapProvider.selectedRestaurant = null;
          mapProvider.notifyListeners(); // 지도를 탭하면 카드 숨기기
        },
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          _buildNaverMap(),
          // _buildRestaurantCard(mapProvider), // 식당 정보 카드 추가
        ],
      ),
    );
  }
}
