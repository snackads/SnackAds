import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/feed_upload_controller.dart';

class FeedUploadSelectView extends StatelessWidget {
  const FeedUploadSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    FeedUploadController feedUploadController =
        Provider.of<FeedUploadController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: selectionButton(
                  context, FontAwesomeIcons.camera, '영상 촬영하기', () {
                dev.log('영상 촬영 모드');
                feedUploadController.getVideo(ImageSource.camera, context);
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: selectionButton(context, Icons.photo, '앨범에서 업로드하기', () {
                dev.log('앨범 업로드 모드');
                feedUploadController.getVideo(ImageSource.gallery, context);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget selectionButton(
    BuildContext context, IconData icon, String text, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      //  TODO: 어플 메인 컬러로 디자인 수정
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
