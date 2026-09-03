import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:movies_app/core/config/them/text_them.dart';
import '../config/them/app_color.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key,  this.onTap, required this.text, this.background, this.strokeColor, this.titleColor, this.img, });

  final void Function()? onTap;
  final String text;
  final Color? background;
  final Color? strokeColor;
  final Color? titleColor;
  final Widget? img;


  @override
  Widget build(BuildContext context) {
    final them = Theme.of(context);
    return Bounceable(
      onTap: (){

        onTap?.call();

      },
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.primary ,

        ),
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ?img,
                  SizedBox(width: 16,),

                Text(text ,style: TextThem.robotoRegular20DarkGray),
              ],
            )),
      ),
    );
  }
}
