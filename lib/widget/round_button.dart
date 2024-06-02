import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/text_style_manager.dart';

class RoundButton<T extends Widget> extends StatelessWidget {
  final void Function() onTap;
  final double radius;
  final String text;
  final Color color;
  final T? headerImage;
  final bool isDarkTheme;
  final double? headerLeftPaddingSize;

  const RoundButton(
      {super.key,
      required this.onTap,
      required this.radius,
      required this.text,
      required this.color,
      this.headerImage,
      required this.isDarkTheme,
      this.headerLeftPaddingSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: 56,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: color),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: headerLeftPaddingSize ?? 24),
                child: headerImage,
              ),
            ),
            Center(
              child: Text(text,
                  style: isDarkTheme
                      ? TextStyleManager.componentsW600light
                      : TextStyleManager.componentsW600darker),
            )
          ],
        ),
      ),
    );
  }
}
