import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_tomato/Controllers/auth_controller.dart';
import 'package:game_tomato/Screens/game_page.dart';
import 'package:game_tomato/Controllers/firestore_services.dart';
import 'package:game_tomato/Screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../Models/score_model.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var firestoreServices = FirestoreServices();
  String scoredOn= "";
  final user = FirebaseAuth.instance.currentUser;
  ScoreModel scoreModel = ScoreModel(highestScore: 0, timeAchieved: Timestamp.fromDate(DateTime.now()));

  @override
  void initState() {
    super.initState();
    getScoreData();
  }

  /// Retrieves and updates the highest score data for the current user.
  ///
  /// This method uses [firestoreServices] to fetch the highest score data for
  /// the user identified by [user!.uid]. The obtained [ScoreModel] is then stored
  /// in the [scoreModel] variable, and the [scoredOn] variable is set with a
  /// formatted date and time string using [DateFormat].
  Future<void> getScoreData() async{
    ScoreModel _scoreModel = await firestoreServices.getHighestScore(user!.uid) ;
    setState(() {
      scoreModel=_scoreModel;
      scoredOn = DateFormat('MMM-dd-yy : HH:mm').format(scoreModel.timeAchieved.toDate());
    });
  }

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
                image: AssetImage("assets/images/bg_home.png"),
                fit: BoxFit.fill,
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user?.photoURL ?? "https://img.freepik.com/premium-vector/smiling-tomato-fruit-cartoon-mascot-giving-thumbs-up-vector-illustration-red-tomato-character-wi_714603-685.jpg?w=2000"),
                radius: 30,
              ),
              Text(
                user?.displayName ?? "Username",
                style: GoogleFonts.courgette(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF09084E),
                ),
              ),
              SizedBox(height: 30,),
              Text(
                //"Highest: $highest",
                "Your Highest Score is",
                style: GoogleFonts.shizuru(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF09084E),
                ),
              ),
              Text(
                scoreModel.highestScore.toString(),
                style: GoogleFonts.beauRivage(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Color(0xFF09084E),
                ),
              ),
              Text(
                "Scored on: ",
                style: GoogleFonts.shizuru(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF09084E),
                ),
              ),
              SizedBox(height: 5,),
              Text(
                  scoredOn,
                style: GoogleFonts.beauRivage(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF09084E),
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> const GamePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF09084E),
                  foregroundColor: Colors.white
                ),
                child: Text("Start game"),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: (){
                  final provider = Provider.of<AuthController>(context, listen: false);
                  provider.logoutUser();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8F0808),
                    foregroundColor: Colors.white
                ),
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
