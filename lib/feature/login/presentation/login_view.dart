import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/core/config/them/app_color.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/main.dart';

import '../../../core/config/them/text_them.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19.0,vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/images/play_img.png',width: 120, height: 120,),
                SizedBox(height: 69,),
                CustomTextFormField(hint: 'Email',prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset('assets/icons/email.icon.svg'),
                ),),
                SizedBox(height: 22,),
                CustomTextFormField(hint: 'Password',prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset('assets/icons/password.svg'),
                ),
                  suffixIcon: Icon(Icons.visibility_off,color: AppColor.whiteColor,),
                ),
                SizedBox(height: 17,),
                GestureDetector(
                    onTap: (){
                    navigatorKey.currentState?.pushNamed(AppRoutesName.forgetPassword);

                },
                    child: Text('Forget Password?',style: TextThem.robotoRegular14Yellow,textAlign: TextAlign.end, )),
                SizedBox(height: 33,),
                CustomButton(text: 'Login'),
                SizedBox(height: 22,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t Have Account ?', style: TextThem.robotoRegular14White,),
                    SizedBox(width: 2,),
                    GestureDetector(
                      onTap: (){
                        navigatorKey.currentState?.pushNamed(AppRoutesName.register);
                        
                      },
                        child:
                    Text('Create One',style: TextThem.robotoRegular14Yellow.copyWith(fontWeight: FontWeight.w900),)),
                  ],
                ),
                SizedBox(height: 27,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(color: AppColor.primary,endIndent: 10, indent: 60,)),
                    Text('OR',style: TextThem.robotoRegular15Yellow,),
                    Expanded(child: Divider(color: AppColor.primary,endIndent: 60, indent: 10, )),
                  ],
                ),
                SizedBox(height: 18,),
                CustomButton( onTap: (){navigatorKey.currentState?.pushNamed(AppRoutesName.profile); }, img: SvgPicture.asset('assets/icons/icon _google.svg'), text: 'Login With Google',),
                SizedBox(height: 33,),
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 150.0),
                  child: Container(
                      height: 38,
                      width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.primary,width: 1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        SvgPicture.asset('assets/icons/usa_icon.svg'),
                        SizedBox(width: 10,),
                        SvgPicture.asset('assets/icons/egy_icon.svg')


                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
