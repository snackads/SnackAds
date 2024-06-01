import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

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
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF343945),
      body: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _naverMapSection())),
    );
  }

  Future<List<NMarker>> _fetchMarkersFromFirestore() async {
    List<NMarker> markers = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('restaurants').get();

      log("Firestore returned ${querySnapshot.docs.length} documents");

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        log("Document data: $data");

        NOverlayCaption caption = NOverlayCaption(
          text: data['name'] ?? 'Unknown',
        );

        NMarker marker = NMarker(
          id: data['rid'],
          position: NLatLng(data['latitude'], data['longitude']),
          caption: caption,
        );

        markers.add(marker);
      }
    } catch (e) {
      log('Error fetching markers from Firestore: $e');
    }

    return markers;
  }

  Widget _naverMapSection() {
    if (_currentPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<List<NMarker>>(
      future: _fetchMarkersFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          log("No restaurant markers found");
          return const Center(child: Text('No restaurants found'));
        }

        List<NMarker> markers = snapshot.data!;

        return NaverMap(
          options: NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(
              target: NLatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 17,
              bearing: 0,
              tilt: 0,
            ),
            indoorEnable: true,
            locationButtonEnable: true,
            consumeSymbolTapEvents: false,
          ),
          onMapReady: (controller) async {
            mapController = controller;
            mapControllerCompleter.complete(controller);
            log("onMapReady", name: "onMapReady");

            // Add current location marker
            final currentLocationMarker = NMarker(
              id: 'current_location',
              position: NLatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
            );
            controller.addOverlay(currentLocationMarker);

            // Add restaurant markers
            controller.addOverlayAll(markers.toSet());

            // Optionally, open info window for each marker
            for (var marker in markers) {
              final onMarkerInfoWindow = NInfoWindow.onMarker(
                  id: marker.info.id, text: marker.caption!.text);
              marker.openInfoWindow(onMarkerInfoWindow);
            }
          },
        );
      },
    );
  }
}
