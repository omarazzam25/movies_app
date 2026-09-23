import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../service/snack_bar.dart';

class FirebaseAuthService {

static Future<bool> createAccount(String email , String password) async{
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return Future.value(true);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      SnackBarHelper.showErrorSnackBar('The password provided is too weak.');

      return Future.value(false);
    } else if (e.code == 'email-already-in-use') {
      SnackBarHelper.showErrorSnackBar(
        'The account already exists for that email.',
      );
      return Future.value(false);
    }
    return Future.value(false);
  } catch (e) {
    SnackBarHelper.showErrorSnackBar('Something Went Wrong');
    return Future.value(false);
  }

}
static Future<bool> loginAccount(String email , String password) async{

  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return Future.value(true);

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

static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

static Future<UserCredential?> signInWithGoogle() async {
 try {
   await _googleSignIn.initialize(
       serverClientId: dotenv.env['CLIENT_SERVER_ID']);

   final GoogleSignInAccount result = await _googleSignIn.authenticate();

   final googleAuth = result.authentication;

   final credential = GoogleAuthProvider.credential(
     idToken: googleAuth.idToken,
   );
   return await FirebaseAuth.instance.signInWithCredential(credential);
 } catch(e){

   SnackBarHelper.showErrorSnackBar('Something Went Wrong ' );
   return null;

 }
}


static Future<bool> forgotPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email.trim(),
    );



    return true;
  } on FirebaseAuthException catch (e) {
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







}




