import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../core/api/api_manager.dart';
import '../../../../core/api/model/all_movies_response.dart';
import '../../../../core/config/them/app_color.dart';
import '../../../../core/config/them/screen_size.dart';
import '../../../../core/config/them/text_them.dart';
import '../../../../core/utils/app_assets.dart';
import '../widget/genre_movies_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  late Future<AllMoviesResponse> moviesFuture;

  @override
  void initState() {
    super.initState();
    moviesFuture = ApiManager.getAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AllMoviesResponse>(
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
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  moviesList[currentIndex].largeCoverImage ?? "",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Container(color: Color(0xB3000000)),
                ),
              ),

              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: context.height * 0.05),
                    Image.asset(AppAssets.availableNowImage),
                    SizedBox(height: context.height * 0.03),
                    CarouselSlider.builder(
                      itemCount: moviesList.length,
                      itemBuilder: (context, index, realIndex) {
                        return GestureDetector(
                          onTap: () {
                            //  Navigator
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: context.width * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      moviesList[index].largeCoverImage ?? "",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: context.height * 0.02,
                                left: context.width * 0.03,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0x66000000),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        moviesList[index].rating?.toString() ??
                                            "unrated",
                                        style: TextThem.robotoRegular16White,
                                      ),
                                      SizedBox(width: context.width * 0.01),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: context.height * 0.45,
                        enlargeCenterPage: true,
                        viewportFraction: 0.7,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: context.height * 0.02),
                    Image.asset(AppAssets.watchNowImage),
                    SizedBox(height: context.height * 0.02),
                    GenreMoviesWidget(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
