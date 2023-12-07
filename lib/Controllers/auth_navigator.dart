import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_tomato/Screens/sign_in_page.dart';
import '../Screens/home_page.dart';
import '../Screens/splash_screen.dart';

/// A widget that navigates the user based on the authentication state.
///
/// The AuthNavigator listens to the authentication state changes using the
/// authStateChanges stream provided by FirebaseAuth.instance. It displays
/// different screens depending on whether the user is authenticated or not.
///
/// If the authentication state is still waiting, it shows a SplashScreen.
/// If the user is authenticated, it navigates to the HomePage.
/// If there's an error during the authentication process, it displays an error message.
/// If the user is not authenticated, it shows the SignInPage.
class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            // Show a loading splash screen while waiting for the authentication state
            return SplashScreen();
          } else if (snapshot.hasData){
            // User is authenticated, navigate to the home page
           return HomePage();
          } else if (snapshot.hasError){
            // Display an error message if there's an issue with authentication
            return Center(child: Text("Error signing in with google"),);
          } else{
            // User is not authenticated, show the sign-in page
            return SignInPage();
          }
        },
      ),
    );
  }
}
