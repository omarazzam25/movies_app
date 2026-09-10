import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/widgets/custom_button.dart';

import '../../../core/config/them/app_color.dart';
import '../../../core/config/them/text_them.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Avatar',style: TextThem.robotoRegular14Yellow,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 37),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage('assets/images/man_profile.png'),
              ),
            ),
            SizedBox(height: 35,),
            CustomTextFormField(hint: 'John Safwat',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset('assets/icons/user_icon.svg'),
              ),),
        SizedBox(height: 22,),
        CustomTextFormField(hint: '01200000000',prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/icons/phone.svg'),
        ),
        ),
            SizedBox(height: 22,),
            Text('Reset Password',style: TextThem.robotoRegular20White,),
           Spacer(),
            CustomButton(text:'Delete Account',background: AppColor.redColor, titleColor: TextThem.robotoRegular20White,),
            CustomButton(text:'Update Data' ),
          ],
        ),
      ),
    );
    
  }
}
