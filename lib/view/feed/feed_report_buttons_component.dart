import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/report_controller.dart';
import 'package:snack_ads/model/shortform.dart';

Widget reportButtonComponent(
    BuildContext context, ShortForm video, PageController pageController) {
  ReportController reportController = Provider.of<ReportController>(context);
  return PopupMenuButton<String>(
    icon: Icon(FontAwesomeIcons.ellipsisVertical,
        size: 25, color: Colors.grey[300]),
    onSelected: (String value) {
      if (value.compareTo('report') == 0) {
        reportController.reportVideoToDB(video);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('신고되었습니다. 감사합니다 :)'),
            duration: Duration(seconds: 1),
          ),
        );
        pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
    ],
  );
}
