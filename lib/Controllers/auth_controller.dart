import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

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

      /*final UserDetails userDetails = UserDetails(
        userId: googleUser!.id,
        displayName: googleUser.displayName ?? "User",
        email: googleUser.email,
        photoUrl: googleUser.photoUrl ?? 'https://img.freepik.com/premium-vector/smiling-tomato-fruit-cartoon-mascot-giving-thumbs-up-vector-illustration-red-tomato-character-wi_714603-685.jpg?w=2000',
      );*/

    } catch(e){
      print("Error: $e");
    }
    notifyListeners();

  }
  Future<void> logoutUser() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

}