import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/api/api_manager.dart';
import '../../../../core/api/model/movie_by_genre_response.dart';
import '../../../../core/config/routes/app_routes_name.dart';
import '../../../../core/config/them/app_color.dart';
import '../../../../core/config/them/screen_size.dart';
import '../../../../core/config/them/text_them.dart';
import '../../../../main.dart';


class GenreMoviesWidget extends StatefulWidget {
  const GenreMoviesWidget({super.key});

  @override
  State<GenreMoviesWidget> createState() => _GenreMoviesWidgetState();
}

class _GenreMoviesWidgetState extends State<GenreMoviesWidget> {
  late Future<MoviesByGenreResponse> moviesFuture;
  List<String> genresList = [
    'action',
    'adventure',
    'animation',
    'anime',
    'comedy',
    'crime',
    'documentary',
    'drama',
    'family',
    'fantasy',
    'horror',
    'music',
    'musical',
    'mystery',
    'reality TV',
    'romance',
    'sci-fi',
    'seasonal',
    'short',
    'sport',
    'thriller',
  ];
  var random = Random();
  late String randomGenre = genresList[random.nextInt(genresList.length)];

  @override
  void initState() {
    super.initState();
    moviesFuture = ApiManager.getMoviesByGenre(randomGenre, 15);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MoviesByGenreResponse>(
      future: moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColor.whiteColor,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error snapshot");
        }
        if (snapshot.data?.status == "error") {
          debugPrint("error status ");
          return Text("Error status");
        }
        var moviesList = snapshot.data?.data?.movies ?? [];
        if (moviesList.isEmpty) {
          return Center(
            child: Text(
              "No Sources Found",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(randomGenre, style: TextThem.robotoRegular20White),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See More",
                          style: TextThem.robotoRegular16Yellow,

                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: AppColor.primary,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: context.height * 0.015),

            /// Horizontal Movies List
            SizedBox(
              height: context.height * 0.17,
              child: ListView.builder(
                padding: EdgeInsets.only(left: context.width * 0.02),
                scrollDirection: Axis.horizontal,
                itemCount: moviesList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      navigatorKey.currentState?.pushNamed(AppRoutesName.movieDetails,arguments: moviesList[index].id );
                      },
                    child: Container(
                      margin: EdgeInsets.only(right: context.width * 0.03),
                      width: context.width * 0.25,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              moviesList[index].mediumCoverImage ?? "",
                              fit: BoxFit.cover,
                              width: context.width * 0.25,
                              height: context.height * 0.17,
                            ),
                          ),
                          Positioned(
                            top: 6,
                            left: 6,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xB3000000),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    moviesList[index].rating?.toStringAsFixed(
                                          1,
                                        ) ??
                                        "unrated",
                                    style: TextThem.robotoRegular10White,
                                  ),
                                  SizedBox(width: 3),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: context.height * 0.1),
          ],
        );
      },
    );

  }
}
