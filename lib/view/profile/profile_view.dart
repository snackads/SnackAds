import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/profile_service.dart';
import 'dart:developer' as dev;

import 'package:snack_ads/model/app_user.dart';
import 'package:snack_ads/view/profile/liked_view.dart';
import 'package:snack_ads/view/profile/uploaded_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileService = Provider.of<ProfileService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              dev.log("Press Settings", name: "Profile");
              context.push('/setting');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(AppUser().photoURL ?? "default"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppUser().nickname ?? "NoNickName",
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text("@${AppUser().name ?? "NoName"}"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(180, 40),
                      minimumSize: const Size(120, 40),
                    ),
                    onPressed: () async {
                      await profileService.loadUploadedVideoList();
                      profileService.setScreen(isUploaded: true);
                    },
                    child: const Text("내가 추가한 장소"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(180, 40),
                      minimumSize: const Size(120, 40),
                    ),
                    onPressed: () async {
                      await profileService.loadLikedVideoList();
                      profileService.setScreen(isUploaded: false);
                    },
                    child: const Text("좋아요한 장소"),
                  ),
                ],
              ),
            ),
            // TODO: 나중에 추가한 장소 & 북마크 장소 저장 기능 나오면 추가해야함
            profileService.isUploaded
                ? const Expanded(child: UploadedView())
                : const Expanded(child: LikedView()),
          ],
        ),
      ),
    );
  }
}
