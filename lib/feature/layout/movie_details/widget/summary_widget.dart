import 'package:flutter/material.dart';

import '../../../../core/config/them/text_them.dart';

class SummaryWidget extends StatelessWidget {
  final String summary;

  const SummaryWidget({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Text(summary, style: TextThem.robotoRegular16White);
  }
}
