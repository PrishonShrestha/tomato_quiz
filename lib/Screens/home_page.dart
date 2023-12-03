import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_tomato/Controllers/auth_controller.dart';
import 'package:game_tomato/Screens/game_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://i.pinimg.com/564x/43/38/4f/43384f77640c7e61466ef6656e053591.jpg",),
              fit: BoxFit.fill,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> const GamePage()),
                  );
                },
                child: Text("Start game"),
              ),
              ElevatedButton(
                onPressed: (){
                  final provider = Provider.of<AuthController>(context, listen: false);
                  provider.logoutUser();
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
