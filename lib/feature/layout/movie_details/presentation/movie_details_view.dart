import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/api/model/inner_classes/movie.dart';
import '../../../../core/config/them/app_color.dart';
import '../cubit/movie_details_state.dart';
import '../cubit/movie_details_view_model.dart';
import 'movie_details_item.dart';

class MovieDetailsView extends StatelessWidget {
  final Movie movie;
  const MovieDetailsView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        int movieId = movie.id ?? 0;

        String uId = FirebaseAuth.instance.currentUser?.uid ?? '';

        return MovieDetailsCubit()..getMovieDetails(movieId, uId);
      },
      child: const MovieDetailsViewBody(),
    );
  }
}

class MovieDetailsViewBody extends StatelessWidget {
  const MovieDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsErrorState) {
            return Center(child: Text(state.message));
          }

          if (state is MovieDetailsSuccessState) {
            final movie = state.movie;

            return MovieDetailsItem(movie: movie);
          }

          return Center(
            child: CircularProgressIndicator(color: AppColor.primary),
          );
        },
      ),
    );
  }
}
