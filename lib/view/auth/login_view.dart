import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/authentication_controller.dart';
import 'package:snack_ads/controller/bottom_navigation_controller.dart';
import 'package:snack_ads/util/color_manager.dart';
import 'dart:developer' as dev;

import 'package:snack_ads/util/text_style_manager.dart';
import 'package:snack_ads/widget/round_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationController =
        Provider.of<AuthenticationController>(context);
    authenticationController.isUserLoggedIn = () {
      dev.log('User is logged in', name: "isUserLoggedIn");
      Provider.of<BottomNavigationController>(context, listen: false)
          .changeTabIndex(0);

      context.go('/main');
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/app_logo_1152px.png',
              height: 200,
              width: 200,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 24)),
            Text(
              '환영합니다!\n스낵에드 앱 로그인 후 다양한 서비스를\n자유롭게 이용해 보세요!',
              textAlign: TextAlign.center,
              style: TextStyleManager.textW600Light,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 64)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: RoundButton(
                onTap: () => Platform.isIOS
                    ? authenticationController.signInWithApple(context: context)
                    : authenticationController.signInWithGoogle(
                        context: context),
                radius: 13,
                text: Platform.isIOS ? 'Apple로 시작하기' : "구글로 시작하기",
                color: Platform.isIOS
                    ? ColorManager.black
                    : ColorManager.googleLoginButtonBg,
                headerImage: Platform.isIOS
                    ? SvgPicture.asset('assets/icons/icon_apple.svg')
                    : SvgPicture.asset('assets/icons/icon_google.svg'),
                isDarkTheme: true,
                headerLeftPaddingSize: Platform.isIOS ? null : 2,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 12)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: RoundButton(
                onTap: () => context.push('/email'),
                radius: 13,
                text: '이메일로 시작하기',
                color: ColorManager.grey01,
                headerImage: Image.asset(
                  'assets/icons/ic_mail.png',
                  width: 24,
                  height: 24,
                ),
                isDarkTheme: false,
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: Container(
        height: 24,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 36),
        child: Text(
          '고객센터 문의하기',
          style: TextStyleManager.componentsUnderline,
        ),
      ),
    );
  }
}
