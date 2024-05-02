import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedButtons extends StatelessWidget {
  const FeedButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //  like
          buttonDesign('좋아요', FontAwesomeIcons.heart),
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
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
