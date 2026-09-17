import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/config/them/app_color.dart';
import '../../../../core/api/model/inner_classes/movie.dart';
import '../../../../core/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookMarkWidget extends StatelessWidget {
  final Movie movie;

  const BookMarkWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var userId = user?.uid;

    if (userId == null) {
      return const SizedBox();
    }

    return StreamBuilder<DocumentSnapshot<Movie>>(
      stream: FirebaseUtils.watchMovieInWatchList(uId: userId, movie: movie),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Icon(
            Icons.bookmark_border_rounded,
            size: 30,
            color: AppColor.whiteColor,
          );
        }

        bool isSaved = snapshot.data?.exists ?? false;

        return IconButton(
          selectedIcon: const Icon(Icons.bookmark_rounded),
          isSelected: isSaved,
          iconSize: 30,
          color: AppColor.whiteColor,
          icon: const Icon(Icons.bookmark_border_rounded),
          onPressed: () async {
            if (isSaved) {
              await FirebaseUtils.deleteMovieFromWatchList(
                movie: movie,
                uId: userId,
              );
              debugPrint('delete');
            } else {
              await FirebaseUtils.addMovieToWatchList(
                movie: movie,
                uId: userId,
              );
              debugPrint('add');
            }
          },
        );
      },
    );
  }
}
