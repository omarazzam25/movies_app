import 'package:dio/dio.dart';

import '../../../../core/api/model/search_movie_model.dart';

class MovieRepository {
  final Dio dio;

  MovieRepository(this.dio);

  Future<SearchMovieModel> getMovies() async {
    final response = await dio.get(
      'https://yts.gg/api/v2/list_movies.json',
    );

    return SearchMovieModel.fromJson(response.data);
  }
}