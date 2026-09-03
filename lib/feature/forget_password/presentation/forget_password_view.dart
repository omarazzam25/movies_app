import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/widgets/custom_button.dart';

import '../../../core/config/them/app_color.dart';
import '../../../core/config/them/text_them.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../main.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector( onTap: (){navigatorKey.currentState?.pop(); },child: Icon(Icons.arrow_back_outlined,color: AppColor.primary,)),
        title: Text('Forget Password',style: TextThem.robotoRegular14Yellow,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/forgot_password_img.png',fit: BoxFit.cover,),
            SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextFormField(hint: 'Email',prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset('assets/icons/email.icon.svg'),
              ),
              ),
            ),
            SizedBox(height: 24,),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: CustomButton(text: 'Verify Email'))

          ]
        ),
      ),

    );
  }
}
