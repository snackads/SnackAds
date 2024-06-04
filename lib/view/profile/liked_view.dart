import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/profile_service.dart';

class LikedView extends StatelessWidget {
  const LikedView({super.key});

  @override
  Widget build(BuildContext context) {
    // final profileService = Provider.of<ProfileService>(context);

    return Consumer<ProfileService>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.likedVideos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(value.likedVideos[index].restaurantName),
              subtitle: Text(value.likedVideos[index].restaurantAddress),
              leading: Text(value.likedVideos[index].likes.toString()),
            );
          },
        );
      },
    );
  }
}
