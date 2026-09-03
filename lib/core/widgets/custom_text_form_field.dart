import 'package:flutter/material.dart';
import '../config/them/app_color.dart';
import '../config/them/text_them.dart';


class CustomTextFormField extends StatelessWidget {
 const  CustomTextFormField({super.key, required this.hint, this.suffixIcon, this.prefixIcon,  this.keyboardType,  this.isPassword = false , this.validator, this.controller,  this.maxLines = 1, this.onChanged, this.initialValue});
  final String hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? maxLines ;
  final void Function(String)? onChanged;
  final String? initialValue;




  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: AppColor.whiteColor),
      initialValue: initialValue,
      onChanged:onChanged ,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines:maxLines ,
      validator:validator ,
      controller: controller,
      obscureText: isPassword,
      keyboardType:keyboardType ,
      cursorColor:AppColor.primary,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:TextThem.robotoRegular14White ,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor:AppColor.secondary,
        enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

        ),
        focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

        ),
      ),
    );
  }
}


