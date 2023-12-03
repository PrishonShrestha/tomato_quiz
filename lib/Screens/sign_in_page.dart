import 'package:flutter/material.dart';
import 'package:game_tomato/Controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';




class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black12,
      child: Center(
        child: Container(
          //height: 60,
          //width: size.width*0.8,
          //color: Colors.white,
          child: ElevatedButton.icon(
              onPressed: (){
                final provider = Provider.of<AuthController>(context, listen: false);
                provider.signInWithGoogle();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width*0.7, 60),
                backgroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 18),
                foregroundColor: Colors.black,

              ),
              icon: Image.network("https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png", height: 35, width: 35,),
              label: Text("Sign in with google"),

          )
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sign in with google", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
              SizedBox(width: 20,),
              Image.network("https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png", height: 40, width: 40,)
            ],
          ),*/
          /*SignInButton(
            padding: EdgeInsets.all(20),
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            Buttons.google,
            text: "Sign in with google",
            onPressed: (){
              final provider = Provider.of<AuthController>(context, listen: false);
              provider.signInWithGoogle();
            },
          ),*/
        ),
      ),
    );
  }
}
