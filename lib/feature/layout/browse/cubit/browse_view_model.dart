import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api/api_manager.dart';
import 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit() : super(BrowseInitialState());

  Future<void> getBrowseMovies(String genre) async {
    emit(BrowseLoadingState());

    try {
      final response = await ApiManager.getMoviesByGenre(genre, 20);

      final movies = response.data?.movies ?? [];

      if (movies.isEmpty) {
        emit(BrowseEmptyState());
      } else {
        emit(BrowseSuccessState(movies));
      }
    } catch (e) {
      emit(BrowseErrorState(e.toString()));
    }
  }
}
