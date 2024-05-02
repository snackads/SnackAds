import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snack_ads/view/feed/feed_buttons.dart';
import 'package:snack_ads/view/feed/feed_description.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        //  TODO: 새로고침시 새로운 영상 불러오기 추가
        onRefresh: () async {},
        color: Colors.black,
        child: feedScreen(),
      ),
    );
  }
}

Widget feedScreen() {
  return PageView.builder(
    controller: PageController(
      initialPage: 0,
      viewportFraction: 1,
    ),
    //  TODO: feed Model을 담은 영상 목록의 길이
    itemCount: 3,
    scrollDirection: Axis.vertical,
    onPageChanged: (index) {
      // TODO: 스크롤시 재생할 영상을 변경
    },
    itemBuilder: (context, index) {
      return videoScreen();
    },
  );
}

Widget videoScreen() {
  return Stack(
    children: [
      //  TODO: 화면 터치시 영상 멈춤 및 재생 기능 추가
      GestureDetector(
        onTap: () {},
        child: const SizedBox.expand(),
      ),

      const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // TODO: 식당, 영상 설명 텍스트 추가
              FeedDescription(),
              FeedButtons(),
            ],
          ),
          SizedBox(height: 20)
        ],
      ),
    ],
  );
}
