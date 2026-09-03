import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/main.dart';

import '../../../core/config/them/app_color.dart';
import '../../../core/config/them/text_them.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  List<String> images = [
    'assets/images/gamer_profile .png',
    'assets/images/music_profile.png',
    'assets/images/man_profile.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector( onTap: (){navigatorKey.currentState?.pop(); },child: Icon(Icons.arrow_back_outlined,color: AppColor.primary,)),
        title: Text('Register',style: TextThem.robotoRegular14Yellow,),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19.0),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(image:AssetImage(images[itemIndex]),fit: BoxFit.cover),
                              shape: BoxShape.circle
                          ),
                        ),
                    options:CarouselOptions(
                      height: 160,
                      viewportFraction:  158 / MediaQuery.of(context).size.width,
                      enlargeCenterPage: true,
                      enlargeFactor: .5,
                      padEnds: true,
                      enableInfiniteScroll: true
                    ),
                  ),
                ),
                  SizedBox(height: 10,),
                Text('Avatar',style: TextThem.robotoRegular14White,),
                SizedBox(height: 12,),
                CustomTextFormField(hint: 'Name',prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/icons/icon _Identification_.svg'),
                ),),
                SizedBox(height: 22,),

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
                SizedBox(height: 22,),
                CustomTextFormField(hint: 'Confirm Password',prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset('assets/icons/password.svg'),
                ),
                  suffixIcon: Icon(Icons.visibility_off,color: AppColor.whiteColor,),
                ),
                SizedBox(height: 22,),
                CustomTextFormField(hint: 'Phone Number',prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset('assets/icons/phone.svg'),
                ),
                ),
                SizedBox(height: 24,),
                CustomButton(text: 'Create Account'),
                SizedBox(height: 22,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have Account ?', style: TextThem.robotoRegular14White,),
                    SizedBox(width: 2,),
                    GestureDetector(onTap: (){
                      navigatorKey.currentState?.pushReplacementNamed(AppRoutesName.login);
                    } , child: Text('Login',style: TextThem.robotoRegular14Yellow.copyWith(fontWeight: FontWeight.w900),)),
                  ],
                ),

                SizedBox(height: 18,),

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
