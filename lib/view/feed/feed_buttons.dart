import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snack_ads/view/feed/feed_button_design.dart';

class FeedButtons extends StatelessWidget {
  final int likes;
  const FeedButtons({super.key, required this.likes});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //  like
        buttonDesign(numOfLikes(likes), FontAwesomeIcons.heart, () {}),
        //  comments
        //buttonDesign('댓글', FontAwesomeIcons.comment, () {}),
        //  share
        buttonDesign('공유', FontAwesomeIcons.share, () {}),
      ],
    );
  }

  // 좋아요 수 단위 변환
  String numOfLikes(int likes) {
    if (likes >= 1000000000) {
      return '${likes ~/ 1000000000}B';
    } else if (likes >= 1000000) {
      return '${likes ~/ 1000000}M';
    } else if (likes >= 1000) {
      return '${likes ~/ 1000}k';
    } else {
      return likes.toString();
    }
  }
}
