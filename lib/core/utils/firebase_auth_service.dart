import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/model/my_user.dart';
import '../service/snack_bar.dart';
import 'firebase_utils.dart';

class FirebaseAuthService {
  static Future<bool> createAccount(
      String name,
      String email,
      String password,
      ) async {
    try {

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        return false;
      }

      final myUser = MyUser(
        id: firebaseUser.uid,
        name: name.trim(),
        email: email.trim(),
        phone: '',
        avatarIndex: 0,
        provider: AuthProviders.emailPassword,
      );

      await FirebaseUtils.addUserToFireStore(myUser);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarHelper.showErrorSnackBar(
          'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        SnackBarHelper.showErrorSnackBar(
          'The account already exists for that email.',
        );
      } else if (e.code == 'invalid-email') {
        SnackBarHelper.showErrorSnackBar(
          'Please enter a valid email.',
        );
      } else {
        SnackBarHelper.showErrorSnackBar(
          e.message ?? 'Something went wrong.',
        );
      }

      return false;
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(
        'Something Went Wrong',
      );

      return false;
    }
  }

  static Future<bool> loginAccount(
      String email,
      String password,
      ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarHelper.showErrorSnackBar(
          'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        SnackBarHelper.showErrorSnackBar(
          'Wrong password provided for that user.',
        );
      } else if (e.code == 'invalid-credential') {
        SnackBarHelper.showErrorSnackBar(
          'Email or password is incorrect.',
        );
      } else if (e.code == 'invalid-email') {
        SnackBarHelper.showErrorSnackBar(
          'Please enter a valid email.',
        );
      } else {
        SnackBarHelper.showErrorSnackBar(
          'Something went wrong: ${e.code}',
        );
      }

      return false;
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(
        'Something went wrong',
      );

      return false;
    }
  }

  static final GoogleSignIn _googleSignIn =
      GoogleSignIn.instance;

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: dotenv.env['CLIENT_SERVER_ID'],
      );

      final GoogleSignInAccount result =
      await _googleSignIn.authenticate();

      final googleAuth = result.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        return null;
      }


      final existingUser =
      await FirebaseUtils.readUserFromFireStore(
        firebaseUser.uid,
      );


      if (existingUser == null) {
        final myUser = MyUser(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? 'User',
          email: firebaseUser.email ?? '',
          phone: firebaseUser.phoneNumber ?? '',
          avatarIndex: 0,
          provider: AuthProviders.google,
        );

        await FirebaseUtils.addUserToFireStore(myUser);
      }

      return userCredential;
    } catch (e) {
      debugPrint('GOOGLE SIGN IN ERROR: $e');

      SnackBarHelper.showErrorSnackBar(
        'Something Went Wrong',
      );

      return null;
    }
  }

  static Future<bool> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.trim(),
      );

      return true;
    } on FirebaseAuthException {
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(
        'Something went wrong',
      );

      return false;
    }
  }

  static Future<bool> deleteAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return false;
      }


      await FirebaseUtils.deleteUserFromFirestore(user.uid);


      await user.delete();

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint('DELETE ACCOUNT ERROR: ${e.code}');
      return false;
    } catch (e) {
      debugPrint('DELETE ACCOUNT ERROR: $e');
      return false;
    }
  }

  static Future<bool> updateUser({
    required String name,
    required String phone,

  }) async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        return false;
      }

      final currentUser =
      await FirebaseUtils.readUserFromFireStore(firebaseUser.uid);

      if (currentUser == null) {
        return false;
      }

      final updatedUser = MyUser(
        id: currentUser.id,
        name: name.trim(),
        email: currentUser.email,
        phone: phone.trim(),
        avatarIndex: currentUser.avatarIndex,
        provider: currentUser.provider,
      );

      await FirebaseUtils.updateUserDataToFirestore(updatedUser);

      return true;
    } catch (e) {
      debugPrint('UPDATE USER ERROR: $e');
      return false;
    }
  }


}