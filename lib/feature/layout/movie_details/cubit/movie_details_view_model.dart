import 'package:bloc/bloc.dart';
import '../../../../core/api/api_manager.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitState());

  Future<void> getMovieDetails(int movieId, String uId) async {
    emit(MovieDetailsLoadingState());

    try {
      final response = await ApiManager.getMoviesDetails(movieId);

      final movie = response.data?.movie;

      if (movie != null) {
        //  await FirebaseUtils.addMovieToHistory(movie: movie, uId: uId);

        emit(MovieDetailsSuccessState(movie: movie));
      } else {
        emit(MovieDetailsErrorState(message: 'Movie not found'));
      }
    } catch (e) {
      emit(MovieDetailsErrorState(message: e.toString()));
    }
  }
}
