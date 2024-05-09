import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:developer' as dev;

import 'package:go_router/go_router.dart';

Widget reportButtonComponent(BuildContext context) {
  return PopupMenuButton<String>(
    icon: Icon(FontAwesomeIcons.ellipsisVertical,
        size: 25, color: Colors.grey[300]),
    onSelected: (String value) {
      if (value.compareTo('report') == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('신고되었습니다. 감사합니다 :)'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        context.push('/upload');
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'report',
        child: Text(
          '신고하기',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      const PopupMenuItem<String>(
        value: 'upload',
        child: Text('영상 업로드(임시)'),
      ),
    ],
  );
}
