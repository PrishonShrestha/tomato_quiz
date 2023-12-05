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
      //color: Colors.black12,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/welcome.png"),
          fit: BoxFit.fill,
        )
      ),
      child: Center(
        child: ElevatedButton.icon(
          onPressed: (){
            final provider = Provider.of<AuthController>(context, listen: false);
            provider.signInWithGoogle();
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(size.width*0.7, 60),
            backgroundColor: Color(0xFFF7F6C1),
            textStyle: TextStyle(fontSize: 18),
            foregroundColor: Colors.black,
          ),
          icon: Image.asset("assets/images/googleicon.png", height: 35, width: 35,),
          label: Text("Sign in with google"),

        )
      ),
    );
  }
}
