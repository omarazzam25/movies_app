
import 'package:flutter/material.dart';

import '../../../../core/config/them/app_color.dart';
import '../../../../core/config/them/text_them.dart';



class GenresTabBar extends StatelessWidget {
  final bool isSelected;
  final String category;
  final void Function()? onTap;

  const GenresTabBar({
    super.key,
    required this.isSelected,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        alignment: AlignmentGeometry.center,
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: isSelected
                ? AppColor.transparentColor
                : AppColor.primary,
            width: 2,
          ),
          color: isSelected
              ? AppColor.primary
              : AppColor.transparentColor,
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        child: Text(
          category,
          style: isSelected
              ? TextThem.interBold20yellow.copyWith(
            color: AppColor.blackColor,
          )
              : TextThem.interBold20yellow,
        ),
      ),
    );
  }
}
