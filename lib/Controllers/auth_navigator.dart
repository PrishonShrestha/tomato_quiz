import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_tomato/Screens/game_page.dart';
import 'package:game_tomato/Screens/sign_in_page.dart';

import '../Screens/home_page.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData){
            return HomePage();
          } else if (snapshot.hasError){
            return Center(child: Text("Error signing in with google"),);
          } else{
            return SignInPage();
          }

        },
      ),
    );
  }
}