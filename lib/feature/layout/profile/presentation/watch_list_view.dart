import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/config/routes/app_routes_name.dart';
import 'package:movies_app/main.dart';

import '../../../../core/api/model/inner_classes/movie.dart';
import '../../../../core/config/them/app_color.dart';
import '../../../../core/config/them/text_them.dart';
import '../../../../core/utils/firebase_utils.dart';
import '../../home/widget/movie_card.dart';

class WatchListView extends StatelessWidget {
  const WatchListView({super.key});

  @override
  Widget build(BuildContext context) {

    final userId = FirebaseAuth.instance.currentUser?.uid;
    return   StreamBuilder<QuerySnapshot<Movie>>(
      stream: FirebaseUtils.getWatchListMovies(userId!),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.primary,),

          );
        }

        if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {
          return Center(
            child: Image.asset(
              'assets/images/empty.png',
              width: 124,
              height: 124,
            ),
          );
        }

        final movies = snapshot.data!.docs
            .map((doc) => doc.data())
            .toList();

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: movies.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final movie = movies[index];

              return GestureDetector(
                onTap: () {
                  navigatorKey.currentState?.pushNamed(
                    AppRoutesName.movieDetails,
                    arguments: movie.id,
                  );
                },
                child: MovieCard(
                  imageUrl: movie.largeCoverImage ?? '',
                  rating: movie.rating,
                  width: 160,
                  height: 240,
                  ratingTextStyle:
                  TextThem.robotoRegular10White,
                  starSize: 14,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
