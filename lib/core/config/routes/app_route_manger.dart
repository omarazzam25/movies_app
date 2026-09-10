
import 'package:flutter/material.dart';
import 'package:movies_app/feature/layout/layout_view.dart';

import '../../../feature/edit_profile/presentation/edit_profile_view.dart';
import '../../../feature/forget_password/presentation/forget_password_view.dart';
import '../../../feature/login/presentation/login_view.dart';
import '../../../feature/onboarding/presentation/onboarding_view.dart';
import '../../../feature/register/presentation/register_view.dart';
import '../../../feature/splash/splash_view.dart';
import 'app_routes_name.dart';

abstract class AppRouteManger {

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {

    switch(settings.name){
      case AppRoutesName.initial:
        return MaterialPageRoute(builder: (context) => const SplashView(),settings: settings);

        case AppRoutesName.onboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingView(),settings: settings);



        case AppRoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginView(),settings: settings);

        case AppRoutesName.register:
        return MaterialPageRoute(builder: (context) => const RegisterView(),settings: settings);

        case AppRoutesName.forgetPassword:
        return MaterialPageRoute(builder: (context) => const ForgetPasswordView(),settings: settings);

        case AppRoutesName.editProfile:
        return MaterialPageRoute(builder: (context) => const EditProfileView(),settings: settings);

        case AppRoutesName.layout:
        return MaterialPageRoute(builder: (context) => const LayoutView(),settings: settings);






        default:
          return MaterialPageRoute(builder: (context) => const SplashView(),settings: settings);



    }


  }



}