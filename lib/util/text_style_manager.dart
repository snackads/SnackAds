import 'package:flutter/material.dart';

import 'color_manager.dart';

class TextStyleManager {
  static const handwriting = TextStyle(
    fontFamily: 'HandwritingStyle',
    color: ColorManager.black,
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 20 / 15,
  );

  static TextStyle textW600Light =
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 18);

  static TextStyle textW600Medium =
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 20);

  static TextStyle componentsW600light = const TextStyle(
      fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18);

  static TextStyle componentsW600darkerLight = const TextStyle(
      fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16);

  static TextStyle componentsW600darker = const TextStyle(
      fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18);

  static TextStyle componentsUnderline = const TextStyle(
    color: Colors.black,
    decoration: TextDecoration.underline,
  );

  static TextStyle textDescription =
      const TextStyle(color: ColorManager.black001, fontSize: 16);

  static TextStyle textDescriptionBold = const TextStyle(
      color: ColorManager.grey01, fontWeight: FontWeight.w600, fontSize: 14);

  static const h1 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 36 / 24,
  );
  static const h2 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 34 / 24,
  );

  static const h2white = TextStyle(
    color: ColorManager.white,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 34 / 24,
  );

  static const h3 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 34 / 24,
  );
  static const h4 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 28 / 20,
  );

  static const h4white = TextStyle(
    color: ColorManager.white,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 28 / 20,
  );
  static const h5 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 22 / 16,
  );
  static const h6 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1,
  );
  static const h6white = TextStyle(
    color: ColorManager.white,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1,
  );

  static const h7 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    fontSize: 17,
    height: 22 / 16,
  );

  static const h7white = TextStyle(
    color: ColorManager.white,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    fontSize: 17,
    height: 22 / 16,
  );

  static const h8 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 22 / 16,
  );

  static const h8white = TextStyle(
    color: ColorManager.white,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 22 / 16,
  );

  static TextStyle h8Color({Color? color}) {
    // 정적 메서드로 변경
    return TextStyle(
      color: color ?? ColorManager.black, // color 파라미터가 null이면 기본 색상 사용
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w400,
      fontSize: 18,
      height: 22 / 16,
    );
  }

  static const body0 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1,
  );

  static const body1 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 24 / 17,
  );

  static const body2 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 22 / 15,
  );
  static const body2black1 = TextStyle(
    color: ColorManager.black1,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 22 / 15,
  );
  static const body2white = TextStyle(
    color: ColorManager.white,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 22 / 15,
  );

  static const body3 = TextStyle(
    letterSpacing: -0.02,
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 18 / 13,
  );

  static const body3grey09 = TextStyle(
    letterSpacing: -0.02,
    color: ColorManager.grey09,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 18 / 13,
  );

  static const body3black1 = TextStyle(
    letterSpacing: -0.02,
    color: ColorManager.black1,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 18 / 13,
  );

  static const body4 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 22 / 16,
  );

  static const body4navy = TextStyle(
    color: ColorManager.navy,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 22 / 16,
  );
  static const body4bold = TextStyle(
    color: ColorManager.navy,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 22 / 16,
  );
  static const body5 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 20 / 15,
  );
  static const body5white = TextStyle(
    color: ColorManager.white,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 14 / 14,
  );

  static const body6 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    fontSize: 15,
    height: 18 / 13,
  );
  static const body6primary = TextStyle(
    color: ColorManager.primary,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    fontSize: 15,
    height: 18 / 13,
  );
  static const body7 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 22 / 16,
  );

  static const body7white = TextStyle(
    color: ColorManager.white,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 24 / 17,
  );

  static const body7grey = TextStyle(
    color: ColorManager.grey09,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    letterSpacing: -0.02,
    fontSize: 16,
    height: 24 / 17,
  );
  //styleName: Body/Body7;

  static const body7red = TextStyle(
    color: ColorManager.red,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 14 / 14,
  );

  static const body8 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 14 / 14,
  );

  static const body8grey = TextStyle(
    color: ColorManager.grey09,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 14 / 14,
  );

  static const body9 = TextStyle(
    color: ColorManager.black,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    fontSize: 17,
    height: 24 / 17,
  );

  static final chatbody1 = TextStyle(
      color: ColorManager.widgetTextColor,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w400,
      fontSize: 10,
      height: 1.6);

  static final chatbody2 = TextStyle(
    color: ColorManager.widgetTextColor,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.6,
  );
}
