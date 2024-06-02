import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/authentication_controller.dart';
import 'package:snack_ads/util/text_style_manager.dart';
import 'package:snack_ads/widget/round_corner_container.dart';
import '../../../util/color_manager.dart';

class InputSignInPage extends StatefulWidget {
  const InputSignInPage({super.key});

  @override
  State<InputSignInPage> createState() => _InputSignInPageState();
}

class _InputSignInPageState extends State<InputSignInPage> {
  // 추가된 부분: 키보드 상태 감지
  @override
  void initState() {
    super.initState();

    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        setState(() => showLogo = false);
      } else {
        _checkIfAllFocusNodesAreUnfocused();
      }
    });

    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() => showLogo = false);
      } else {
        _checkIfAllFocusNodesAreUnfocused();
      }
    });
  }

  void _checkIfAllFocusNodesAreUnfocused() {
    if (!emailFocusNode.hasFocus && !passwordFocusNode.hasFocus) {
      setState(() => showLogo = true);
    }
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(_checkIfAllFocusNodesAreUnfocused);
    passwordFocusNode.removeListener(_checkIfAllFocusNodesAreUnfocused);

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  bool get isiOS =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  bool inLoginProcess = false;
  double keyboardHeight = 0;
  bool showLogo = true;

  bool obscurePassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  String emailError = '';
  String passwordError = '';

  Future<void> _loginHandler() async {
    await Provider.of<AuthenticationController>(context, listen: false)
        .signInWithEmailAndPassword(
            context: context,
            email: emailController.text,
            password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: SvgPicture.asset("assets/icons/ic_back_button.svg"),
                ),
                titleSpacing: 0,
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "이메일로 시작하기",
                    style: TextStyleManager.textW600Medium,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 96),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/logo/app_logo_1152px.png',
                        height: 200,
                        width: 200,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 48)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: RoundCornerContainer(
                            boxRadius: 16,
                            borderColor: ColorManager.grey08,
                            color: ColorManager.grey07,
                            child: Container(
                              alignment: Alignment.center,
                              height: 56,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '이메일',
                                    hintStyle: TextStyleManager.textW600Medium
                                        .copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.black2),
                                  ),
                                  style: TextStyleManager.textW600Medium
                                      .copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                  controller: emailController,
                                ),
                              ),
                            )),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 12)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: RoundCornerContainer(
                            boxRadius: 16,
                            borderColor: ColorManager.grey08,
                            color: ColorManager.grey07,
                            child: Container(
                              alignment: Alignment.center,
                              height: 56,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '비밀번호',
                                        hintStyle: TextStyleManager
                                            .textW600Medium
                                            .copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: ColorManager.black2),
                                      ),
                                      style: TextStyleManager.textW600Medium
                                          .copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                      controller: passwordController,
                                      obscureText: obscurePassword,
                                    )),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () => setState(() {
                                              obscurePassword =
                                                  !obscurePassword;
                                            }),
                                        icon: Image.asset(
                                          obscurePassword
                                              ? "assets/icons/ic_visible.png"
                                              : "assets/icons/ic_invisible.png",
                                          width: 24,
                                          height: 24,
                                        ))
                                  ],
                                ),
                              ),
                            )),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 24)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: RoundCornerContainer(
                          boxRadius: 12,
                          borderColor: ColorManager.primary100,
                          color: ColorManager.primary100,
                          child: InkWell(
                            onTap: _loginHandler,
                            child: Container(
                              height: 56,
                              alignment: Alignment.center,
                              child: Text("로그인",
                                  style: TextStyleManager.textW600Medium
                                      .copyWith(
                                          color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 24)),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
