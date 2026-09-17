import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/config/them/app_color.dart';
import '../../../../core/config/them/text_them.dart';

class RatingWidget extends StatelessWidget {
  final String? text;
  final String icon;

  const RatingWidget({super.key, required this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.secondary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
            ),
            Text(
              text!,
              style: TextThem.robotoBold20White,
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }
}
