import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies_app/core/config/routes/app_route_manger.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/core/config/them/app_them.dart';

import 'core/service/loading_indicator.dart';
import 'core/service/snack_bar.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState> ();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env" );

  runApp(const MyApp());

  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      scaffoldMessengerKey: SnackBarHelper.scaffoldMessengerKey,
      initialRoute: AppRoutesName.initial,
      onGenerateRoute: AppRouteManger.onGenerateRoute,
      builder: EasyLoading.init(),
    );
  }
}



