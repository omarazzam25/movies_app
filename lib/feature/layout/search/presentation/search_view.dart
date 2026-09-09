import 'package:flutter/material.dart';

import '../../../../core/config/them/text_them.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('SSearch Screen', style: TextThem.robotoRegular20White,),
      ),
    );
  }
}
