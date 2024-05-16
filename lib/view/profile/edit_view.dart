import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/edit_controller.dart';
import 'package:snack_ads/model/app_user.dart';

import 'dart:developer' as dev;

class EditView extends StatelessWidget {
  const EditView({super.key});

  @override
  Widget build(BuildContext context) {
    final EditController edit = Provider.of<EditController>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

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
                controller: TextEditingController(text: AppUser().email),
                readOnly: true,
                decoration: const InputDecoration(
                  filled: true,
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
                controller: edit.nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  edit.nameController.text = value;
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
                controller: edit.nicknameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  edit.nicknameController.text = value;
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
                controller: edit.phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "'-' 없이 작성해주세요 (예: 01012345678)",
                ),
                onChanged: (value) {
                  edit.phoneController.text = value;
                },
              ),
            ],
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
                if (edit.nameController.text.isEmpty ||
                    edit.nicknameController.text.isEmpty) {
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
                    "name": edit.nameController.text,
                    "nickname": edit.nicknameController.text,
                    "phone": edit.phoneController.text == ""
                        ? null
                        : edit.phoneController.text,
                  };
                  edit.editProfileInfo(data);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("성공적으로 수정되었습니다."),
                    duration: Duration(seconds: 1),
                  ));

                  edit.clearController();
                  context.pushReplacement('/main');
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
