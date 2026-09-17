import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/api/api_manager.dart';
import '../../../../core/api/model/suggestion_response.dart';
import '../../../../core/api/widget/main_loading_widget.dart';
import '../../../../core/config/them/text_them.dart';

class SimilarMovieWidget extends StatelessWidget {
  final int movieId;

  const SimilarMovieWidget({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SuggestionResponse>(
      future: ApiManager.getSuggestionDetails(movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MainLoadingWidget();
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'sorry_we_were_unable_to_upload_similar_movies',
              style: TextThem.robotoBold20White,
            ),
          );
        }
        final response = snapshot.data;

        if (response == null ||
            response.status == "error" ||
            response.data == null ||
            response.data!.movies == null) {
          return Center(
            child: Text(
              'sorry_we_were_unable_to_upload_similar_movies',
              style: TextThem.robotoBold20White,
            ),
          );
        } else {
          final moviesList = response.data!.movies!;

          return GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: moviesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final movie = moviesList[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: movie.mediumCoverImage ?? '',
                        placeholder: (context, url) =>
                            const MainLoadingWidget(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.rating?.toString() ?? '',
                              style: TextThem.robotoRegular14White,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
