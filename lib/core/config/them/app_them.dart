import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/core/config/them/text_them.dart';

import 'app_color.dart';

abstract class AppTheme {
  static ThemeData darkTheme = ThemeData(
    dialogTheme: DialogThemeData(
        backgroundColor: AppColor.secondary
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed
    ),
    scaffoldBackgroundColor: AppColor.blackColor,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      // backgroundColor: AppColor.primary,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColor.primary),
      titleTextStyle: TextThem.robotoRegular16Yellow,
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
  );
}