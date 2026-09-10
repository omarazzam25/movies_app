import 'package:flutter/material.dart';
import 'package:movies_app/core/config/them/text_them.dart' as custom_theme;
 class MainErrorWidget extends StatelessWidget {
  final String errorMessage ;
  final VoidCallback onPressed ;
  const MainErrorWidget({super.key,required this.errorMessage,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(errorMessage,
          style: Theme
              .of(context)
              .textTheme
              .labelMedium,),
        ElevatedButton(onPressed:onPressed,
            child: Text('Try Again',

              style: custom_theme.TextThem.interSBold20Black ,
            ))
      ],
    );
  }
}
