import 'package:flutter/material.dart';
import '../../../../core/config/them/app_color.dart';
import '../../../../core/config/them/text_them.dart';

class GenresWidget extends StatelessWidget {
  final List<String> genresList;

  const GenresWidget({super.key, required this.genresList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genresList.map((genre) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.secondary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(genre, style: TextThem.robotoRegular16White),
        );
      }).toList(),
    );
  }
}
