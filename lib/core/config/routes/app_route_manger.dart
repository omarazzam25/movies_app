
import 'package:flutter/material.dart';

import '../../../feature/forget_password/presentation/forget_password_view.dart';
import '../../../feature/login/presentation/login_view.dart';
import '../../../feature/onboarding/presentation/onboarding_view.dart';
import '../../../feature/profile/presentation/profile_view.dart';
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

        case AppRoutesName.profile:
        return MaterialPageRoute(builder: (context) => const ProfileView(),settings: settings);





        default:
          return MaterialPageRoute(builder: (context) => const SplashView(),settings: settings);



    }


  }



}