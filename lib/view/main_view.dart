// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/bottom_navigation_controller.dart';
import 'package:snack_ads/view/profile_view.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  late BottomNavigationController _bottomNavigationController;

  Widget _navigationBody() {
    switch (_bottomNavigationController.tabIndex) {
      case 0:
        return Container(color: Colors.red);
      case 1:
        return Container(color: Colors.green);
      case 2:
        return Container(color: Colors.blue);
      case 3:
        return const ProfileView();
      default:
        return Container(color: Colors.red);
    }
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      // 현재 페이지
      currentIndex: _bottomNavigationController.tabIndex,
      // 현재 페이지 탭했을 시
      onTap: (index) {
        _bottomNavigationController.changeTabIndex(index);
      },
      unselectedItemColor: Colors.grey[300],
      selectedItemColor: Colors.white,

      items: const [
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(FontAwesomeIcons.mapLocation),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(FontAwesomeIcons.solidHeart),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(FontAwesomeIcons.user),
          label: 'Profile',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavigationController =
        Provider.of<BottomNavigationController>(context);

    return Scaffold(
      body: _navigationBody(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
