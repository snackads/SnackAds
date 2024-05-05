import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/authentication_controller.dart';
import 'package:snack_ads/model/user.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController =
        Provider.of<AuthenticationController>(context);
    final loggedInUser = authenticationController.currentUser;

    // TextEditingControllers
    final TextEditingController nameController =
        TextEditingController(text: loggedInUser?.displayName);
    final TextEditingController nicknameController = TextEditingController();
    final TextEditingController phoneController =
        TextEditingController(text: "");

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('회원 정보 입력하기'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이메일
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "이메일",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                controller: TextEditingController(text: loggedInUser?.email),
                enabled: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              // 이름
              const Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "이름   ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Text(
                      "*", // 닉네임 텍스트와 공백 없이 붙이기 위해 앞에 공백을 추가
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red, // 빨간색으로 표시
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  nameController.text = value;
                },
              ),

              const SizedBox(height: 30),

              // 닉네임
              const Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "닉네임   ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Text(
                      "*", // 닉네임 텍스트와 공백 없이 붙이기 위해 앞에 공백을 추가
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red, // 빨간색으로 표시
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: nicknameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  nicknameController.text = value;
                },
              ),

              const SizedBox(height: 30),

              // 전화번호
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "전화번호",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "'-' 없이 작성해주세요 (예: 01012345678)",
                ),
                onChanged: (value) {
                  phoneController.text = value;
                },
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    nicknameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "필수 입력 항목을 확인해주세요.",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                } else {
                  User currentUser = User(
                    name: nameController.text,
                    nickname: nicknameController.text,
                    email: loggedInUser?.email,
                    uid: loggedInUser!.uid,
                    phone: phoneController.text == ""
                        ? null
                        : phoneController.text,
                  );
                  authenticationController
                      .addUserInfoToFirestore(currentUser.toFirestore());
                  context.go('/main');
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "저장하기",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
