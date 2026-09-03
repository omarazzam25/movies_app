import 'package:flutter/material.dart';

import '../../../core/config/them/app_color.dart';
import '../../../core/config/them/screen_size.dart';
import '../../../core/config/them/text_them.dart';


class OnboardinButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const OnboardinButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,),
      width:context.width,
      height: context.height * 0.06,
      child: isOutlined
          ? ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.transparentColor,
          side: BorderSide(color: AppColor.primary,width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
            text,
            style: TextThem.interSBold20yellow
        ),
      )
          : ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
        child: Text(
            text,
            style: TextThem.interSBold20Black
        ),
      ),
    );
  }
}