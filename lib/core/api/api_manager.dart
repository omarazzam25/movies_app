import 'package:dio/dio.dart';
import 'model/all_movies_response.dart';
import 'model/movie_by_genre_response.dart';

/*

https://movies-api.accel.li/api/v2/list_movies.json

 */

class ApiManager {
  static final Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://movies-api.accel.li/api/v2/",
      )
  );

  static Future<AllMoviesResponse> getAllMovies() async {
    try {
      var response = await dio.get(
        "list_movies.json",
      );
      var json = response.data;
      return AllMoviesResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }



  static Future<MoviesByGenreResponse> getMoviesByGenre(
      String genre,
      int limit,
      ) async {
    try {
      var response = await dio.get(
        "list_movies.json",
        queryParameters: {'genre': genre, 'limit': limit},
      );
      var json = response.data;
      return MoviesByGenreResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<AllMoviesResponse> getMoviesBySearch(String searchText) async {
    try {
      var response = await dio.get(
        "list_movies.json",
        queryParameters: {
          "query_term": searchText,
        },
      );
      var json = response.data;
      return AllMoviesResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

}
