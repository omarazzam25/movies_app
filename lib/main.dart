import 'package:flutter/material.dart';
import 'package:movies_app/core/config/routes/app_route_manger.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/core/config/them/app_them.dart';

import 'core/service/snack_bar.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState> ();

void main() {
  runApp(const MyApp());
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
    );
  }
}

