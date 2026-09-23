import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/core/config/them/app_color.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/feature/login/login_cubit/login_cubit.dart';
import 'package:movies_app/main.dart';
import '../../../core/config/them/text_them.dart';
import '../../../core/service/snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/language_custom_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }
  @override
  Widget build(BuildContext context) {

    return BlocProvider<LoginCubit>(
  create: (context) => LoginCubit(),
      child:BlocConsumer<LoginCubit,LoginState>(
          listener:(context, state) {
            if(state is LoginLoadingState){
              EasyLoading.show();
            }else if(state is LoginSuccessState){
              EasyLoading.dismiss();
              SnackBarHelper.showSuccessSnackBar('Login Successfully');
              navigatorKey.currentState?.pushReplacementNamed(AppRoutesName.layout);
            }else if(state is LoginFailureState){
              EasyLoading.dismiss();
              SnackBarHelper.showErrorSnackBar(state.message);
            }
            },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 37),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/play_img.png',
                          width: 120,
                          height: 120,
                        ),
                        SizedBox(height: 69),
                        CustomTextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          hint: 'Email',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset('assets/icons/email.icon.svg'),
                          ),
                        ),
                        SizedBox(height: 22),
                        CustomTextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          isPassword: !isPasswordVisible,
                          hint: 'Password',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset('assets/icons/password.svg'),
                          ),
                          suffixIcon: IconButton(
                            onPressed: togglePasswordVisibility,
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColor.whiteColor,
                            ),
                          ),
                          //suffixIcon: Icon(Icons.visibility_off,color: AppColor.whiteColor,),
                        ),
                        SizedBox(height: 17),
                        GestureDetector(
                          onTap: () {
                            navigatorKey.currentState?.pushNamed(
                              AppRoutesName.forgetPassword,
                            );
                          },
                          child: Text(
                            'Forget Password?',
                            style: TextThem.robotoRegular14Yellow,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(height: 33),
                        CustomButton(
                          text: 'Login',
                          onTap: () {
                            if (_formKey.currentState!.validate()){
                              context.read<LoginCubit>().login(emailController.text, passwordController.text);
                            }
                          },
                        ),
                        SizedBox(height: 22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t Have Account ?',
                              style: TextThem.robotoRegular14White,
                            ),
                            SizedBox(width: 2),
                            GestureDetector(
                              onTap: () {
                                navigatorKey.currentState?.pushNamed(
                                  AppRoutesName.register,
                                );
                              },
                              child: Text(
                                'Create One',
                                style: TextThem.robotoRegular14Yellow.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 27),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColor.primary,
                                endIndent: 10,
                                indent: 60,
                              ),
                            ),
                            Text('OR', style: TextThem.robotoRegular15Yellow),
                            Expanded(
                              child: Divider(
                                color: AppColor.primary,
                                endIndent: 60,
                                indent: 10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18),
                        CustomButton(
                          onTap: () {
                            context.read<LoginCubit>().loginWithGoogle();
                            },
                          img: SvgPicture.asset('assets/icons/icon _google.svg'),
                          text: 'Login With Google',
                        ),
                        SizedBox(height: 33),
                        LanguageCustomWidget(),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      )
);
  }
}



