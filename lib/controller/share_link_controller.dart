import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class SharedLinkController with ChangeNotifier {
  late DynamicLinkParameters parameters;
  String videoURL = '';

  void Function()? isURLExist;

  Future<Uri> createDynamicLink(String videoId) async {
    parameters = DynamicLinkParameters(
      uriPrefix: 'https://snackads.page.link',
      link: Uri.parse('https://snackads.page.link/videos/$videoId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.snack_ads',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.example.snackAds',
        minimumVersion: '0',
      ),
    );

    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    dev.log(shortLink.shortUrl.toString());
    return shortLink.shortUrl;
  }

  void updateLink(String url) {
    videoURL = url;
    isURLExist!();
    notifyListeners();
  }
}
