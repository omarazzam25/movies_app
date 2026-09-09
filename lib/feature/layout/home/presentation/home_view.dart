import 'package:flutter/material.dart';

import '../../../../core/config/them/text_them.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen', style: TextThem.robotoRegular20White,),
      ),
    );
  }
}
