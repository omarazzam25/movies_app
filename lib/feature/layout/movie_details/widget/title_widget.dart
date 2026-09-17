import 'package:flutter/material.dart';
import '../../../../core/config/them/text_them.dart';

class TitleWidget extends StatelessWidget {
  final String text;

  const TitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextThem.robotoBold24White,
      textAlign: TextAlign.start,
    );
  }
}
