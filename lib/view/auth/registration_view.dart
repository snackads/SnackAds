import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/authentication_controller.dart';
import 'package:snack_ads/controller/register_controller.dart';
import 'package:snack_ads/model/shortform.dart';
import 'package:snack_ads/model/app_user.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authenticationController =
        Provider.of<AuthenticationController>(context);
    final RegisterController registerController =
        Provider.of<RegisterController>(context);

    final loggedInUser = authenticationController.currentUser;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('회원 정보 입력하기'),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                  readOnly: true,
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
                  controller: registerController.nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    registerController.nameController.text = value;
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
                  controller: registerController.nicknameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    registerController.nicknameController.text = value;
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
                  controller: registerController.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "'-' 없이 작성해주세요 (예: 01012345678)",
                  ),
                  onChanged: (value) {
                    registerController.phoneController.text = value;
                  },
                ),

                const SizedBox(height: 30),

                // 전화번호
                const Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "역할   ",
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
                // 드롭다운 형식으로 "점주", "사용자" 선택하게 해줘
                DropdownButton<String>(
                  value: registerController.roleController.text,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 16,
                  isExpanded: true,
                  onChanged: (value) {
                    dev.log(value ?? "null", name: "Dropdown");
                    if (value != null) {
                      registerController.setRole(value);
                    } else {
                      dev.log("value is null", name: "Role Selection");
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: "--당신의 역할을 선택해주세요--",
                      child: Text(
                        "--당신의 역할을 선택해주세요--",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "점주",
                      child: Text(
                        "점주",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: "사용자",
                      child: Text(
                        "사용자",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 40,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (registerController.nameController.text.isEmpty ||
                    registerController.nicknameController.text.isEmpty ||
                    registerController.roleController.text ==
                        "--당신의 역할을 선택해주세요--") {
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
                  Map<String, dynamic> data = {
                    "name": registerController.nameController.text,
                    "nickname": registerController.nicknameController.text,
                    "email": loggedInUser?.email,
                    "photoURL": loggedInUser?.photoURL,
                    "uid": loggedInUser!.uid,
                    "phone": registerController.phoneController.text == ""
                        ? null
                        : registerController.phoneController.text,
                    "position": registerController.roleController.text,
                    "uploadedShortForms": List<String>.empty(),
                    "likedShortForms": List<String>.empty(),
                  };
                  AppUser().init(data);
                  dev.log(AppUser().toFirestore().toString(), name: "AppUser");
                  registerController.addUserInfoToFirestore(
                      loggedInUser.uid, AppUser().toFirestore());
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
