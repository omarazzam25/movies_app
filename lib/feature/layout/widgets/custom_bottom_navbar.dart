import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/config/them/app_color.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      'assets/icons/home.svg',
      'assets/icons/search.svg',
      'assets/icons/explore.svg',
      'assets/icons/Profile.svg',
    ];

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      height: 64,
      decoration: BoxDecoration(
        color: AppColor.secondary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          icons.length,
              (index) {
            final isSelected = currentIndex == index;

            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.transparent,
                  // border: isSelected
                  //     ? Border.all(
                  //   color: Colors.blue,
                  //   width: 2,
                  // )
                  //     : null,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    icons[index],
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? AppColor.primary
                          : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}