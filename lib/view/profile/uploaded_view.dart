import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/profile_service.dart';

class UploadedView extends StatelessWidget {
  const UploadedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileService>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.uploadedVideos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(value.uploadedVideos[index].restaurantName),
              subtitle: Text(value.uploadedVideos[index].restaurantAddress),
              leading: Text(value.uploadedVideos[index].likes.toString()),
            );
          },
        );
      },
    );
  }
}
