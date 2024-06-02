import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:snack_ads/widget/snackbars/info_snackbar.dart';
import '../../../util/color_manager.dart';

String nameErrorMsg = "사용불가한 이름입니다.";
String emailErrorMsg = "사용불가한 이메일입니다.";
String passwordErrorMsg = "사용불가한 비밀번호입니다.";
String passwordConfirmErroMsg = "비밀번호가 다릅니다.";

Map<int, String> errorCodeToMsgDict = {
  0: nameErrorMsg,
  1: emailErrorMsg,
  2: passwordErrorMsg,
  3: passwordConfirmErroMsg,
};

class InputSignUpPage extends StatefulWidget {
  const InputSignUpPage({super.key});

  @override
  State<InputSignUpPage> createState() => _InputSignUpPageState();
}

class _InputSignUpPageState extends State<InputSignUpPage> {
  bool get isiOS =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  bool isSignInProcess = false;
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordConfirmFocusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  String? nameErrorState;
  String? emailErrorState;
  String? passwordErrorState;
  String? passwordMatchErrorState;

  double keyboardHeightState = 0;
  bool showLogo = true;

  bool isPasswordHidden = true;

  void _fetchKeyboardHeight() {
    keyboardHeightState = MediaQuery.of(context).viewInsets.bottom;
  }

  @override
  void initState() {
    super.initState();

    // Initialize focus node listeners
    nameFocusNode.addListener(_scrollToFocusedNode);
    emailFocusNode.addListener(_scrollToFocusedNode);
    passwordFocusNode.addListener(_scrollToFocusedNode);
    passwordConfirmFocusNode.addListener(_scrollToFocusedNode);
  }

  void _scrollToFocusedNode() {
    bool shouldShowLogo = true;
    if (nameFocusNode.hasFocus) {
      _scrollToOffset(
          100); // Adjust the offset value based on the position of name field
      shouldShowLogo = false;
    } else if (emailFocusNode.hasFocus) {
      _scrollToOffset(
          150); // Adjust the offset value based on the position of email field
      shouldShowLogo = false;
    } else if (passwordFocusNode.hasFocus) {
      _scrollToOffset(
          200); // Adjust the offset value based on the position of password field
      shouldShowLogo = false;
    } else if (passwordConfirmFocusNode.hasFocus) {
      _scrollToOffset(
          300); // Adjust the offset value based on the position of confirm password field
      shouldShowLogo = false;
    }
    if (shouldShowLogo != showLogo) {
      setState(() => showLogo = shouldShowLogo);
    }
  }

  void _scrollToOffset(double offset) {
    _scrollController.animateTo(
      offset,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    nameFocusNode.removeListener(_scrollToFocusedNode);
    emailFocusNode.removeListener(_scrollToFocusedNode);
    passwordFocusNode.removeListener(_scrollToFocusedNode);
    passwordConfirmFocusNode.removeListener(_scrollToFocusedNode);
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordConfirmFocusNode.dispose();
    _scrollController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _fetchKeyboardHeight();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final screenWidthRatio = screenWidth / 390;
        final screenHeightRatio = screenHeight / 793;
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false, // 이 부분을 추가해주세요.
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            const AssetImage("assets/logo/app_logo_1152px.png"),
                        fit: screenWidth > 600 ? BoxFit.cover : BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                _buildContent(screenWidthRatio, screenHeightRatio),
                Align(
                  alignment: const Alignment(0, -0.4),
                  child: showLogo
                      ? _buildLogo(screenWidthRatio, screenHeightRatio)
                      : _buildLogoOpacity(screenWidthRatio, screenHeightRatio),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Center _buildContent(double screenWidthRatio, double screenHeightRatio) {
    return Center(
      child: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(bottom: keyboardHeightState),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 240 * screenHeightRatio)),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              _buildNameTextField(screenWidthRatio, screenHeightRatio),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              _buildEmailTextField(
                  screenWidthRatio, screenHeightRatio, context),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              _buildPasswordTextField(screenWidthRatio, screenHeightRatio),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              _buildPasswordConfirmTextField(
                  screenWidthRatio, screenHeightRatio),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              _buildSignupButton(screenWidthRatio, screenHeightRatio),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginHandler() async {}

  bool _validateFormData() {
    final List<int> invalidFormIndex = [];
    if (!_validateName(nameController.text)) invalidFormIndex.add(0);
    if (!_validateEmail(emailController.text)) invalidFormIndex.add(1);
    if (!_validatePassword(passwordController.text)) invalidFormIndex.add(2);
    if (!_validatePasswordConfirm(
        passwordConfirmController.text, passwordController.text)) {
      invalidFormIndex.add(3);
    }

    if (invalidFormIndex.isEmpty) return true;

    for (int code in errorCodeToMsgDict.keys) {
      if (invalidFormIndex.contains(code)) {
        switch (code) {
          case 0:
            nameErrorState = errorCodeToMsgDict[0];
            break;
          case 1:
            emailErrorState = errorCodeToMsgDict[1];
            break;
          case 2:
            passwordErrorState = errorCodeToMsgDict[2];
            break;
          case 3:
            passwordMatchErrorState = errorCodeToMsgDict[3];
            break;
          default:
        }
      }
    }
    setState(() {});

    return false;
  }

  InkWell _buildSignupButton(
      double screenWidthRatio, double screenHeightRatio) {
    return InkWell(
        onTap: () async {
          if (isSignInProcess) return;
          final isValid = _validateFormData();
          if (!isValid) return;
          try {
            isSignInProcess = true;
            await _loginHandler(); // 함수 호출만 하고 async/await 사용하지 않음
          } catch (e) {
            if (!mounted) return;
            infoSnackBar(context: context, msg: "회원가입에 실패하였습니다.");
          } finally {
            isSignInProcess = false;
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(300 * screenWidthRatio / 1),
          ),
          width: 300,
          height: 50,
          child: const Center(
            child: Text(
              "회원가입",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorManager.primary,
                fontSize: 20,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ));
  }

// Refactored _buildNameTextField
  Widget _buildNameTextField(
      double screenWidthRatio, double screenHeightRatio) {
    return _defaultTextField(
      screenWidthRatio: screenWidthRatio,
      focusNode: nameFocusNode,
      onSubmitted: (submitedText) {
        if (!_validateName(submitedText)) {
          setState(() {
            nameErrorState = errorCodeToMsgDict[0];
          });
          return;
        } else if (nameErrorState != null) {
          setState(() => nameErrorState = null);
        }
        if (emailController.text.isEmpty) {
          FocusScope.of(context).requestFocus(emailFocusNode);
        }
      },
      controller: nameController,
      labelText: "이름",
      errorMsg: nameErrorState,
    );
  }

// Refactored _buildEmailTextField
  Widget _buildEmailTextField(
      double screenWidthRatio, double screenHeightRatio, BuildContext context) {
    return _defaultTextField(
      screenWidthRatio: screenWidthRatio,
      focusNode: emailFocusNode,
      onSubmitted: (submitedText) {
        if (!_validateEmail(submitedText)) {
          setState(() {
            emailErrorState = errorCodeToMsgDict[1];
          });
          return;
        } else if (emailErrorState != null) {
          setState(() => emailErrorState = null);
        }
        if (passwordController.text.isEmpty) {
          FocusScope.of(context).requestFocus(passwordFocusNode);
        }
      },
      controller: emailController,
      labelText: "이메일",
      errorMsg: emailErrorState,
    );
  }

// Refactored _buildPasswordTextField
  Widget _buildPasswordTextField(
      double screenWidthRatio, double screenHeightRatio) {
    return _defaultTextField(
      screenWidthRatio: screenWidthRatio,
      focusNode: passwordFocusNode,
      onSubmitted: (submitedText) {
        if (!_validatePassword(submitedText)) {
          setState(() {
            passwordErrorState = errorCodeToMsgDict[2];
          });
          return;
        } else if (passwordErrorState != null) {
          setState(() => passwordErrorState = null);
        }
        if (passwordConfirmController.text.isEmpty) {
          FocusScope.of(context).requestFocus(passwordConfirmFocusNode);
        }
      },
      controller: passwordController,
      labelText: "비밀번호",
      errorMsg:
          passwordErrorState, // Assuming you have a passwordError variable
      obscureText: true,
    );
  }

// Refactored _buildPasswordConfirmTextField
  Widget _buildPasswordConfirmTextField(
      double screenWidthRatio, double screenHeightRatio) {
    return _defaultTextField(
      screenWidthRatio: screenWidthRatio,
      focusNode: passwordConfirmFocusNode,
      onSubmitted: (submitedText) {
        if (!_validatePasswordConfirm(submitedText, passwordController.text)) {
          setState(() {
            passwordMatchErrorState = errorCodeToMsgDict[3];
          });
          return;
        } else if (passwordMatchErrorState != null) {
          setState(() => passwordMatchErrorState = null);
        }
      },
      controller: passwordConfirmController,
      labelText: "비밀번호 확인",
      errorMsg: passwordMatchErrorState,
      obscureText: true,
    );
  }
}

bool _validateEmail(String email) {
  // 정규 표현식을 사용하여 이메일 형식 검사
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  return emailRegExp.hasMatch(email);
}

bool _validatePassword(String password) {
  // 최소 6글자 이상, 영어 1개, 숫자 1개, 특수문자 (!@#$%^&*) 중 1개 포함 검사
  final passwordRegExp =
      RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,}$');
  return passwordRegExp.hasMatch(password);
}

bool _validatePasswordConfirm(String a, String b) {
  return a == b;
}

bool _validateName(String name) {
  return name.isNotEmpty && name.length <= 10;
}

Widget _defaultTextField({
  required double screenWidthRatio,
  FocusNode? focusNode,
  Function(String)? onSubmitted,
  required TextEditingController controller,
  required String labelText,
  String? errorMsg,
  bool obscureText = false,
}) {
  return Container(
      width: 358 * screenWidthRatio,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0x33F5F5F5),
        borderRadius: BorderRadius.circular(13),
      ),
      child: TextField(
        obscureText: obscureText,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(13),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          errorText: errorMsg,
          errorStyle: const TextStyle(overflow: TextOverflow.visible),
          errorMaxLines: 3,
        ),
      ));
}

SvgPicture _buildLogo(double screenWidthRatio, double screenHeightRatio) {
  return SvgPicture.asset(
    "assets/logo/app_logo.svg",
    width: 215 * screenWidthRatio,
    height: 21 * screenHeightRatio,
  );
}

Opacity _buildLogoOpacity(double screenWidthRatio, double screenHeightRatio) {
  return Opacity(
    opacity: 0.2, // 50% 투명도
    child: SvgPicture.asset(
      "assets/logo/app_logo.svg",
      width: 215 * screenWidthRatio,
      height: 21 * screenHeightRatio,
    ),
  );
}
