import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/them/app_color.dart';

class LanguageCustomWidget extends StatelessWidget {
  const LanguageCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 38,
        width: 90,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColor.primary,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/usa_icon.svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 15),
            SvgPicture.asset(
              'assets/icons/egy_icon.svg',
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
