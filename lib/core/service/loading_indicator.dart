import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../config/them/app_color.dart';


void configLoading() {

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = AppColor.whiteColor
    ..indicatorColor = AppColor.primary
    ..textColor = AppColor.primary
    ..maskColor = Colors.blue.withValues(alpha: 0.5)
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = true
    ..dismissOnTap = false ;

}