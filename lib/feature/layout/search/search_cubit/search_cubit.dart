import 'package:bloc/bloc.dart';

import '../../../../core/api/model/search_movie_model.dart' show Movies;
import '../repo/movie_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.repository) : super(SearchInitial());

  final MovieRepository repository;

  List<Movies> allMovies = [];

  Future<void> searchMovie(String query) async {

    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }


    if (allMovies.isEmpty) {
      emit(SearchLoading());

      try {
        final response = await repository.getMovies();

        allMovies = response.data?.movies ?? [];

        if (allMovies.isEmpty) {
          emit(SearchEmpty());
          return;
        }
      } catch (e) {
        emit(SearchError(e.toString()));
        return;
      }
    }


    final searchQuery = query.trim().toLowerCase();

    final filteredMovies = allMovies.where((movie) {
      final title = movie.title?.toLowerCase() ?? '';

      return title.contains(searchQuery);
    }).toList();

    if (filteredMovies.isEmpty) {
      emit(SearchEmpty());
    } else {
      emit(SearchSuccess(filteredMovies));
    }
  }
}

// import 'package:bloc/bloc.dart';
//
// import '../../../../core/api/model/search_movie_model.dart' show Movies;
// import '../repo/movie_repository.dart';
//
//
// part 'search_state.dart';
//
// class SearchCubit extends Cubit<SearchState> {
//   SearchCubit(this.repository) : super(SearchInitial());
//
//   final MovieRepository repository;
//
//   List<Movies> allMovies = [];
//
//    Future<void> getMovies() async {
//      emit(SearchLoading());
//      try {
//        final response = await repository.getMovies();
//        allMovies = response.data?.movies ?? [];
//        emit(SearchSuccess(allMovies));
//      } catch (e) {
//        emit(SearchError(e.toString()));
//
//      }
//
//    }
//
//
//   void searchMovie(String query) {
//     if (query.trim().isEmpty) {
//       emit(SearchSuccess(allMovies));
//       return;
//     }
//
//     final filteredMovies = allMovies.where((movie) {
//       final title = movie.title?.toLowerCase() ?? '';
//
//       return title.contains(query.toLowerCase());
//     }).toList();
//
//     if (filteredMovies.isEmpty) {
//       emit(SearchEmpty());
//     } else {
//       emit(SearchSuccess(filteredMovies));
//     }
//   }
//
//
//
//
//
// }
