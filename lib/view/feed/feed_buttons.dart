import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedButtons extends StatelessWidget {
  final int likes;
  const FeedButtons({super.key, required this.likes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //  like
          buttonDesign(numOfLikes(likes), FontAwesomeIcons.heart),
          //  comments
          buttonDesign('댓글', FontAwesomeIcons.comment),
          //  share
          buttonDesign('공유', FontAwesomeIcons.share),
        ],
      ),
    );
  }

  Widget buttonDesign(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Icon(icon, size: 25, color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
