import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_tomato/Controllers/auth_controller.dart';
import 'package:game_tomato/Screens/game_page.dart';
import 'package:game_tomato/Controllers/firestore_services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  var firestoreServices = FirestoreServices();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        body: FutureBuilder<int>(
          future: firestoreServices.getHighestScore(user!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Display a loading indicator while waiting
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else{
              int highest = snapshot.data ?? 0;
              return Container(
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
                    Text(
                      "Highest: $highest",
                    ),

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
              );
            }

          }
        ),
      ),
    );
  }
}
