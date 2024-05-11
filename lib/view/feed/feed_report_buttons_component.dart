import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snack_ads/controller/feed_report_controller.dart';
import 'package:snack_ads/model/shortform.dart';

Widget reportButtonComponent(
    BuildContext context, ShortForm video, PageController pageController) {
  FeedReportController reportController =
      Provider.of<FeedReportController>(context);
  return PopupMenuButton<String>(
    icon: Icon(FontAwesomeIcons.ellipsis, size: 25, color: Colors.grey[300]),
    onSelected: (String value) {
      if (value.compareTo('report') == 0) {
        reportController.reportVideoToDB(video);
        showMessage(context, pageController);
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

Future showMessage(BuildContext context, PageController pageController) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '해당 글을 신고하시겠습니까?\n\n신고가 누적될 경우\n삭제처리됩니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 90,
                    height: 40,
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('신고되었습니다. 감사합니다 :)'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                  child: Container(
                    width: 90,
                    height: 40,
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        '신고하기',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
