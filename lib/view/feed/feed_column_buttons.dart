import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:snack_ads/controller/feed_controller.dart';
import 'package:snack_ads/controller/shared_link_controller.dart';
import 'package:snack_ads/model/app_user.dart';
import 'package:snack_ads/model/shortform.dart';
import 'package:snack_ads/view/feed/feed_column_buttons_components.dart';

class FeedColumnButtons extends StatelessWidget {
  final FeedController feedProvider;
  final ShortForm video;
  const FeedColumnButtons(
      {super.key, required this.video, required this.feedProvider});

  @override
  Widget build(BuildContext context) {
    SharedLinkController shareLinkProvider =
        Provider.of<SharedLinkController>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //  share
        columnButtonsComponent('공유',
            Icon(FontAwesomeIcons.share, size: 25, color: Colors.grey[300]),
            () async {
          shareLinkProvider
              .createDynamicLink(video.shortFormSid)
              .then((value) => {Share.shareUri(value)});
        }),
        //  like
        columnButtonsComponent(
            numOfLikes(video.likes),
            (isLiked())
                ? Icon(FontAwesomeIcons.solidHeart,
                    size: 25, color: Colors.red[300])
                : Icon(FontAwesomeIcons.heart,
                    size: 25, color: Colors.grey[300]), () {
          feedProvider.pushLikeButton(video);
        }),
        //  comments
        //buttonDesign('댓글', FontAwesomeIcons.comment, () {}),
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

  bool isLiked() {
    return AppUser().likedShortForms.contains(video.shortFormSid);
  }
}
