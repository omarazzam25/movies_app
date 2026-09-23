import 'package:flutter/material.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/main.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),() {

      navigatorKey.currentState?.pushReplacementNamed(AppRoutesName.layout);
    }, );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/play_img.png',width: 250,height: 250,)),
    );
  }
}
