import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/config/them/app_color.dart';
import 'package:movies_app/core/config/them/text_them.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/utils/firebase_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/api/model/inner_classes/movie.dart';
import '../../../../core/api/model/inner_classes/cast.dart';
import '../widget/book_mark_widget.dart';
import '../widget/cast_widget.dart';
import '../widget/genres_widget.dart';
import '../widget/screenShotsWidget.dart';
import '../widget/SimilarMovieCarts.dart';
import '../widget/summary_widget.dart';
import '../widget/title_widget.dart';

class MovieDetailsItem extends StatefulWidget {
  final Movie movie;

  const MovieDetailsItem({super.key, required this.movie});

  @override
  State<MovieDetailsItem> createState() => _MovieDetailsItemState();
}

class _MovieDetailsItemState extends State<MovieDetailsItem> {
  late final List<Cast> castList = widget.movie.cast ?? [];
  late final List<String> genresList = widget.movie.genres ?? [];

  late final List<String> screenShotsList = [
    widget.movie.largeScreenshotImage1 ??
        widget.movie.mediumScreenshotImage1 ??
        '',
    widget.movie.largeScreenshotImage2 ??
        widget.movie.mediumScreenshotImage2 ??
        '',
    widget.movie.largeScreenshotImage3 ??
        widget.movie.mediumScreenshotImage3 ??
        '',
  ].where((url) => url.isNotEmpty).toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.movie.largeCoverImage ?? ""),
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
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: AppColor.whiteColor,
                        ),
                      ),
                      BookMarkWidget(movie: widget.movie),
                    ],
                  ),
                ),
                SvgPicture.asset('assets/icons/play_movie.svg'),
                const SizedBox(height: 180),
                Text(
                  widget.movie.titleEnglish ?? widget.movie.title ?? '',
                  style: TextThem.robotoBold24White,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  widget.movie.year?.toString() ??
                      widget.movie.dateUploaded?.substring(0, 4) ??
                      '',
                  style: TextThem.robotoBold20LightGray,
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomButton(
                    onTap: () async {
                      final String? userId =
                          FirebaseAuth.instance.currentUser?.uid;
                      if (userId != null) {
                        FirebaseUtils.addMovieToHistory(
                          movie: widget.movie,
                          uId: userId,
                        ).catchError((e) {
                          debugPrint('⚠️ failed to add to history: $e');
                        });
                      }
                      if (widget.movie.url?.isNotEmpty == true) {
                        await launchUrl(
                          Uri.parse(widget.movie.url!),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    text: 'watch',
                    background: AppColor.redColor,
                    titleColor: TextThem.robotoBold20White,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoBadge(
                  icon: 'assets/icons/like.svg',
                  text: widget.movie.likeCount?.toString() ?? '0',
                ),
                _InfoBadge(
                  icon: 'assets/icons/time.svg',
                  text: widget.movie.runtime?.toString() ?? '0',
                ),
                _InfoBadge(
                  icon: 'assets/icons/rate.svg',
                  text: widget.movie.rating?.toString() ?? '0',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TitleWidget(text: "screen_shots"),
                const SizedBox(height: 10),
                ScreenShotsWidget(screenShotsList: screenShotsList),
                const SizedBox(height: 15),
                TitleWidget(text: "similar"),
                const SizedBox(height: 10),
                SimilarMovieWidget(movieId: widget.movie.id ?? 0),
                const SizedBox(height: 15),
                const TitleWidget(text: "Summary"),
                const SizedBox(height: 10),
                SummaryWidget(
                  summary:
                      widget.movie.descriptionFull ?? 'sorry_no_summary_found',
                ),
                const SizedBox(height: 15),
                TitleWidget(text: 'cast'),
                const SizedBox(height: 10),
                CastWidget(castList: castList),
                const SizedBox(height: 15),
                const TitleWidget(text: 'Genres'),
                const SizedBox(height: 10),
                GenresWidget(genresList: genresList),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String icon;
  final String text;

  const _InfoBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.secondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, height: 25, width: 28),
          const SizedBox(width: 10),
          Text(text, style: TextThem.robotoBold24White),
        ],
      ),
    );
  }
}
