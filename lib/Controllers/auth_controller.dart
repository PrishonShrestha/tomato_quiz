import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  /// Sign in with Google authentication.
  ///
  /// This method triggers the authentication flow using Google sign-in.
  /// It retrieves the user account information and authentication details,
  /// then creates a GoogleAuthProvider credential for Firebase authentication.
  /// Finally, it signs in the user with the obtained credential using FirebaseAuth.
  ///
  /// Throws an error if any exception occurs during the authentication process.
  ///
  /// After the authentication process, the [notifyListeners] method is called
  /// to notify listeners of any changes, such as the user being signed in.
  Future<void> signInWithGoogle() async {
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch(e){
      print("Error: $e");
    }
    // Notify listeners of any changes
    notifyListeners();
  }

  /// Log out the currently signed-in user.
  ///
  /// This method disconnects the user from Google sign-in and signs them out
  /// from Firebase authentication using [GoogleSignIn] and [FirebaseAuth] respectively.
  Future<void> logoutUser() async {
    // Disconnect from Google sign-in
    await googleSignIn.disconnect();
    // Sign out from Firebase authentication
    FirebaseAuth.instance.signOut();
  }

}