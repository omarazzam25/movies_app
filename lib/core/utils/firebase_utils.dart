import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/model/inner_classes/movie.dart';
import '../api/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
  }

  static Future<void> updateUserDataToFirestore(MyUser user) async {
    var querySnapshot = getUsersCollection().doc(user.id);
    await querySnapshot.update(user.toFireStore());
  }

  static Future<void> deleteUserFromFirestore(String uId) async {
    await getUsersCollection().doc(uId).delete();
  }

  static CollectionReference<Movie> getWatchListCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Movie.watchListCollectionName)
        .withConverter<Movie>(
          fromFirestore: (snapshot, options) => Movie.fromJson(snapshot.data()),
          toFirestore: (movie, options) => movie.toJson(),
        );
  }

  static Future<void> addMovieToWatchList({
    required Movie movie,
    required String uId,
  }) {
    return getWatchListCollection(uId).doc(movie.id.toString()).set(movie);
  }

  static Future<void> deleteMovieFromWatchList({
    required Movie movie,
    required String uId,
  }) {
    return getWatchListCollection(uId).doc(movie.id.toString()).delete();
  }

  static Stream<DocumentSnapshot<Movie>> watchMovieInWatchList({
    required String uId,
    required Movie movie,
  }) {
    return getWatchListCollection(uId).doc(movie.id.toString()).snapshots();
  }

  static CollectionReference<Movie> getHistoryCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Movie.historyCollectionName)
        .withConverter<Movie>(
          fromFirestore: (snapshot, options) => Movie.fromJson(snapshot.data()),
          toFirestore: (movie, options) => movie.toJson(),
        );
  }

  static Future<void> addMovieToHistory({
    required Movie movie,
    required String uId,
  }) {
    return getHistoryCollection(uId).doc(movie.id.toString()).set(movie);
  }

  static Stream<QuerySnapshot<Movie>> getWatchListMovies(
      String uId,
      ) {
    return getWatchListCollection(uId).snapshots();
  }

  static Stream<QuerySnapshot<Movie>> getHistoryMovies(
      String uId,
      ) {
    return getHistoryCollection(uId).snapshots();
  }
}
