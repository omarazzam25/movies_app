import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/config/them/app_color.dart';
import 'package:movies_app/core/config/them/text_them.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/api/model/inner_classes/movie.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.75,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(movie.largeCoverImage ?? ""),
                fit: BoxFit.cover,
              ),
            ),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 29,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          navigatorKey.currentState?.pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: AppColor.whiteColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset('assets/icons/save_icon.svg'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 120),
                SvgPicture.asset('assets/icons/play_movie.svg'),
                SizedBox(height: 180),
                Text(movie.title ?? '', style: TextThem.robotoBold24White),
                SizedBox(height: 15),
                Text(
                  movie.dateUploaded?.substring(0, 4) ?? '',
                  style: TextThem.robotoBold20LightGray,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomButton(
                    onTap: () async {
                      if (movie.url?.isNotEmpty == true) {
                        await launchUrl(
                          Uri.parse(movie.url!),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    text: 'Watch',
                    background: AppColor.redColor,
                    titleColor: TextThem.robotoBold20White,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 22,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColor.secondary,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/like.svg',
                        height: 25,
                        width: 28,
                      ),
                      SizedBox(width: 10),
                      Text(
                        movie.likeCount?.toString() ?? '15',
                        style: TextThem.robotoBold24White,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 22,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColor.secondary,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/time.svg',
                        height: 25,
                        width: 28,
                      ),
                      SizedBox(width: 10),
                      Text(
                        movie.runtime?.toString() ?? '15',
                        style: TextThem.robotoBold24White,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 22,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColor.secondary,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/rate.svg',
                        height: 25,
                        width: 28,
                      ),
                      SizedBox(width: 10),
                      Text(
                        movie.rating?.toString() ?? '15',
                        style: TextThem.robotoBold24White,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text('Screen Shots', style: TextThem.robotoBold24White),
          ),
        ],
      ),
    );
  }
}
