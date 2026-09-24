import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/routes/app_routes_name.dart';
import '../../../../core/config/them/app_color.dart';
import '../../../../core/config/them/screen_size.dart';
import '../cubit/browse_state.dart';
import '../cubit/browse_view_model.dart';
import '../widgets/genres_tab_bar.dart';
import '../widgets/movie_item.dart';

class  BrowseView extends StatefulWidget {
  const BrowseView({super.key});

  @override
  State<BrowseView> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView> {
  late String selectedGenre = genresList[0];
  List<String> genresList = [
    'Action',
    'Adventure',
    'Animation',
    'Anime',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Horror',
    'Music',
    'Musical',
    'Mystery',
    'Reality TV',
    'Romance',
    'Sci-Fi',
    'Seasonal',
    'Short',
    'Sport',
    'Thriller',
  ];

  @override
  void initState() {
    super.initState();
    context.read<BrowseCubit>().getBrowseMovies(selectedGenre);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Column(
          spacing: context.width * 0.04,
          children: [
            DefaultTabController(
              length: genresList.length,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsetsDirectional.only(
                  start: context.width * 0.04,
                ),
                padding: EdgeInsetsDirectional.only(top: context.width * 0.04),
                dividerColor: AppColor.transparentColor,
                indicatorColor: AppColor.transparentColor,
                isScrollable: true,

                onTap: (index) {
                  if (selectedGenre == genresList[index]) return;

                  setState(() {
                    selectedGenre = genresList[index];
                  });

                  context.read<BrowseCubit>().getBrowseMovies(selectedGenre);
                },
                tabs: genresList
                    .map(
                      (genre) =>
                      GenresTabBar(
                        isSelected:
                        selectedGenre ==
                            genresList[genresList.indexOf(genre)],
                        category: genre,
                      ),
                )
                    .toList(),
              ),
            ),
            Expanded(
              child: BlocBuilder<BrowseCubit, BrowseState>(
                builder: (context, state) {
                  if (state is BrowseErrorState) {
                    return Center(child: Text(state.message));
                  }
                  if (state is BrowseEmptyState) {
                    return const Center(
                      child: Text("No Movies Found For This Genre"),
                    );
                  }

                  if (state is BrowseSuccessState) {
                    final movies = state.movies;

                    return GridView.builder(
                      padding: EdgeInsets.only(
                        right: context.width * 0.04,
                        left: context.width * 0.04,
                        bottom: context.height * 0.1,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: context.width * 0.04,
                        mainAxisSpacing: context.width * 0.04,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutesName.movieDetails,
                              arguments: movie.id,
                            );
                          },
                          child: MovieItem(
                            movieImage: movie.mediumCoverImage ?? '',
                            movieRating: movie.rating.toString(),
                          ),
                        );
                      },
                    );
                  }

                  return Center(

                      child: CircularProgressIndicator(

                        color: AppColor.primary,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
