import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/core/utils/firebase_auth_service.dart';
import 'package:movies_app/main.dart';

import '../../../core/config/them/app_color.dart';
import '../../../core/config/them/text_them.dart';
import '../../../core/service/snack_bar.dart';
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

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }



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
            child: Form(
              key: _formKey,
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
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: nameController,
                    keyboardType: TextInputType.name,

                    hint: 'Name',prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset('assets/icons/icon _Identification_.svg'),
                  ),),
                  SizedBox(height: 22,),

                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,


                    hint: 'Email',prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset('assets/icons/email.icon.svg'),
                  ),),
                  SizedBox(height: 22,),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }

                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Password must contain an uppercase letter';
                      }

                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        return 'Password must contain a lowercase letter';
                      }

                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Password must contain a number';
                      }

                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-]').hasMatch(value)) {
                        return 'Password must contain a special character';
                      }
                      return null;
                    },
                    isPassword: !isPasswordVisible,
                    controller: passwordController,

                    hint: 'Password',prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset('assets/icons/password.svg'),
                  ),
                    suffixIcon:
                    IconButton(
                      onPressed: togglePasswordVisibility,
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColor.whiteColor,
                      ),
                    ),
          ),
                  SizedBox(height: 22,),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if(value != passwordController.text){
                        return 'Passwords do not match';

                      }
                      return null;
                      },
                    hint: 'Confirm Password',prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset('assets/icons/password.svg'),
                  ),
                    suffixIcon: Icon(Icons.visibility_off,color: AppColor.whiteColor,),
                  ),
                  SizedBox(height: 22,),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                      },
                    keyboardType: TextInputType.phone,

                    hint: 'Phone Number',prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset('assets/icons/phone.svg'),
                  ),
                  ),
                  SizedBox(height: 24,),
                  CustomButton(
                    text: 'Create Account',

                    onTap: (){
                      if (_formKey.currentState!.validate()) {

                        EasyLoading.show();
                        FirebaseAuthService.createAccount(emailController.text, passwordController.text ).then((value) {
                          EasyLoading.dismiss();
                          if(value){
                            SnackBarHelper.showSuccessSnackBar('Account Created Successfully');
                            navigatorKey.currentState?.pushReplacementNamed(
                              AppRoutesName.login,);

                          }


                        });

                       // navigatorKey.currentState?.pushReplacementNamed(AppRoutesName.login);
                      }


                  },
                  ),
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
      ),

    );
  }
}
