import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snack_ads/view/profile/restaurant_profile_view.dart';

class FeedViewDescription extends StatelessWidget {
  final String videoRid;
  final String videoRestaurantName;
  final String videoRestaurantAddress;
  const FeedViewDescription({
    super.key,
    required this.videoRid,
    required this.videoRestaurantName,
    required this.videoRestaurantAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                log('Restaurant Name Clicked');
                showCupertinoModalPopup(
                  context: context,
                  useRootNavigator: false,
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: RestaurantProfileView(restaurantRid: videoRid),
                    );
                  },
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        //  TODO: 가게 이미지로 추후에 수정
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      videoRestaurantName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              videoRestaurantAddress,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
