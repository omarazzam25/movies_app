import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/config/them/app_color.dart';

abstract class TextThem {

  static final text14 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
     color: AppColor.whiteColor
   );

  static final text20 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
     color: AppColor.secondary
   );

  static final text16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
     color: AppColor.secondary
   );


  static TextStyle interMedium36White = GoogleFonts.inter(
    color: AppColor.whiteColor,
    fontSize: 36,
    fontWeight: FontWeight.w500,
  );
  static TextStyle interRegular20White = GoogleFonts.inter(
    color: AppColor.whiteColor,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static TextStyle interRegular16White = GoogleFonts.inter(
    color: AppColor.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle interSBold20Black = GoogleFonts.inter(
    color: AppColor.blackColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static TextStyle interBold24white = GoogleFonts.inter(
    color: AppColor.whiteColor,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static TextStyle interSBold20yellow = GoogleFonts.inter(
    color: AppColor.primary,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static TextStyle interBold20yellow = GoogleFonts.inter(
    color: AppColor.primary,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  /// roboto font ============================================================
  static TextStyle robotoRegular16White = GoogleFonts.roboto(
    color: AppColor.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,

  );
  static TextStyle robotoRegular14Yellow = GoogleFonts.roboto(
    color: AppColor.primary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle robotoRegular20DarkGray = GoogleFonts.roboto(
    color: AppColor.secondary,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static TextStyle robotoRegular14White = GoogleFonts.roboto(
    color: AppColor.whiteColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle robotoRegular10White = GoogleFonts.roboto(
    color: AppColor.whiteColor,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
  static TextStyle robotoBlack14Yellow = GoogleFonts.roboto(
    color: AppColor.primary,
    fontSize: 14,
    fontWeight: FontWeight.w900,
  );
  static TextStyle robotoRegular15Yellow = GoogleFonts.roboto(
    color: AppColor.primary,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static TextStyle robotoRegular16DarkGray = GoogleFonts.roboto(
    color: AppColor.secondary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle robotoRegular20Black = GoogleFonts.roboto(
    color: AppColor.blackColor,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static TextStyle robotoRegular16Yellow = GoogleFonts.roboto(
    color: AppColor.primary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle robotoRegular20White = GoogleFonts.roboto(
    color: AppColor.whiteColor,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static TextStyle robotoBold20White = GoogleFonts.roboto(
    color: AppColor.whiteColor,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static TextStyle robotoBold24White = GoogleFonts.roboto(
    color: AppColor.whiteColor,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static TextStyle robotoBold20LightGray = GoogleFonts.roboto(
    color: AppColor.lightGrayColor,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static TextStyle robotoBold36White = GoogleFonts.roboto(
    color: AppColor.whiteColor,
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );

}