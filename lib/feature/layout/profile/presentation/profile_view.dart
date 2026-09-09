import 'package:flutter/material.dart';

import '../../../../core/config/them/text_them.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Profile Screen', style: TextThem.robotoRegular20White,),
      ),
    );
  }
}
