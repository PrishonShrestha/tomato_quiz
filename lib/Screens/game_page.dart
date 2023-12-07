import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_tomato/Screens/home_page.dart';
import 'package:game_tomato/Controllers/firestore_services.dart';
import 'package:game_tomato/Screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../Models/question_model.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  GameModel? gameModel;
  static int currentTotalScore = 0;
  List<int> optionsList =[];
  Random random = new Random();
  final firestoreServices = FirestoreServices();
  final user = FirebaseAuth.instance.currentUser;

  late Timer timer;
  int time = 60;

  @override
  void initState() {
    super.initState();
    fetchData();
    currentTotalScore=0;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /// Checks if GameModel contains the question
    if(gameModel?.question != null){
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              "Tomato Quiz",
            style: GoogleFonts.courgette(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: Color(0xFFDCF0FA),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          color: Color(0xFFDCF0FA),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: size.height*0.32,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/frame.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      //child: Image.network(qsn!, height: 200, fit: BoxFit.fill,)
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    height: size.height*0.32,
                    width: size.width,
                    child: Center(
                      child: Image.network(
                        gameModel?.question ?? "https://t4.ftcdn.net/jpg/05/69/98/21/360_F_569982133_DzhJ6XJglSrBEqK6dS7cTdUxD5iWotoD.jpg",
                        height: size.height*0.2,
                        width: size.width*0.65,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
              //SizedBox(height: 20,),
              Container(
                height: 150,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bgimg1.png"),
                    fit: BoxFit.fill,
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Current score: " + currentTotalScore.toString(),
                      style: GoogleFonts.courgette(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Time: " +time.toString(),
                      style: GoogleFonts.courgette(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                  "Select your answer",
                style: GoogleFonts.courgette(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        checkAns(gameModel!.solution, optionsList[0]);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1890C7)
                      ),
                      child: Container(
                          height: 50,
                          width: 80,
                          child: Center(
                              child: Text(
                                optionsList[0].toString(),
                                style: GoogleFonts.courgette(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          )
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        checkAns(gameModel!.solution, optionsList[1]);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1890C7)
                      ),
                      child: Container(
                          height: 50,
                          width: 80,
                          child: Center(
                              child: Text(
                                optionsList[1].toString(),
                                style: GoogleFonts.courgette(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          )
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        checkAns(gameModel!.solution, optionsList[2]);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1890C7)
                      ),
                      child: Container(
                          height: 50,
                          width: 80,
                          child: Center(
                              child: Text(
                                optionsList[2].toString(),
                                style: GoogleFonts.courgette(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          )
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        checkAns(gameModel!.solution, optionsList[3]);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1890C7)
                      ),
                      child: Container(
                          height: 50,
                          width: 80,
                          child: Center(
                              child: Text(
                                optionsList[3].toString(),
                                style: GoogleFonts.courgette(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      /// Returns a splashscreen if their is no data in GameModel
      return SplashScreen();
    }
  }

  /// Starts a countdown timer with a duration of 60 seconds.
  ///
  /// The timer runs in the background, and when the time reaches 0,
  /// it cancels the timer, updates or creates user data in Firestore with the
  /// current total score, and shows an alert dialog with the message "Time over".
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (time == 0) {
          setState(() {
            timer.cancel();

          });
          firestoreServices.updateorCreateData(user!.uid, currentTotalScore);
          alertDialog(context, "Time over");

        } else {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  /// Resets the timer to the initial value of 60 seconds.
  ///
  /// This method is used to reset the countdown timer back to its initial value.
  void resetTimer(){
    setState(() {
      time=60;
    });
  }

  /// Checks the user's answer against the correct answer.
  ///
  /// If the userAns matches the correctAns, the currentTotalScore is increased
  /// by 10, data is fetched, the timer is canceled, and then reset and restarted.
  /// If the answers don't match, the timer is canceled, user data is updated,
  /// and an alert dialog is shown with the message "Wrong answer".
  void checkAns(int correctAns, int userAns){
    if( userAns == correctAns ){
      currentTotalScore = currentTotalScore+10;
      fetchData();
      timer.cancel();
      resetTimer();
      startTimer();
    } else{
      setState(() {
        timer.cancel();
      });
      firestoreServices.updateorCreateData(user!.uid, currentTotalScore);
      alertDialog(context, "Wrong answer");
    }
  }

  /// Generates a list of options for a given solution.
  ///
  /// The solution is added to the list, and then three more random options
  /// (different from the solution) are generated and added to the list. The final
  /// list of options is shuffled.
  void generateOptions(int solution){
    optionsList.clear();
    optionsList.add(solution);
    while (optionsList.length<4){
      int option = random.nextInt(10);
      if(option != solution && !optionsList.contains(option)){
        optionsList.add(option);
      }
    }
    optionsList.shuffle();
    print(solution);
    print(optionsList);
  }

  /// Fetches game data from the specified API endpoint.
  ///
  /// This method performs an HTTP GET request to the given API endpoint and
  /// retrieves game data. If the request is successful (status code 200), the
  /// data is decoded and used to update the [gameModel]. If the request fails,
  /// an exception is thrown with the message 'Failed to load data'.
  ///
  /// After fetching the data, the options for the current question are generated.
  Future<void> fetchData() async{
    final response = await http.get(Uri.parse('https://marcconrad.com/uob/tomato/api.php'));
    if(response.statusCode == 200){
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        gameModel = GameModel.fromJson(data);
        //resetTimer();
      });
    } else{
      throw Exception('Failed to load data');
    }
    generateOptions(gameModel!.solution);
  }

  /// Displays an alert dialog with the specified title and additional content.
  ///
  /// This method shows a modal dialog with an image, a message, and options to replay or go home.
  /// The [context] is used to build the dialog, and the [title] is displayed as part of the message.
  Future<dynamic> alertDialog(BuildContext context, String title) async {
    await showGeneralDialog(
        context: context,
        barrierDismissible: false,
        //builder: (BuildContext builder){
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
          return WillPopScope(
            onWillPop: () async{
              return false;
            },
            child: Center(
              child: Container(
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Text("Oops! $title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, decoration: TextDecoration.none, color: Colors.red),),
                      SizedBox(height: 10,),
                      Image(image: AssetImage("assets/images/sadtomato.gif"), height: 100, width: 250, fit: BoxFit.fill,),
                      SizedBox(height: 10,),
                      Text("Your total score is", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, decoration: TextDecoration.none, color: Colors.black),),
                      SizedBox(height: 10,),
                      Text(currentTotalScore.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, decoration: TextDecoration.none, color: Colors.black),),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF08CA08),
                            ),
                            icon: Icon(Icons.refresh, color: Colors.white, size: 30,),
                            onPressed: (){
                              Navigator.of(context, rootNavigator: true).pop(context);
                              //Navigator.of(context).pop();
                              fetchData();
                              currentTotalScore=0;
                              resetTimer();
                              startTimer();
                            },
                            label: Text("Replay", style: TextStyle(color: Colors.white, fontSize: 16),),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                textStyle: TextStyle(color: Colors.white, fontSize: 16)
                            ),
                            icon: Icon(Icons.home, color: Colors.white, size: 30),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                              );
                              currentTotalScore=0;
                            },
                            label: Text("Home", style: TextStyle(color: Colors.white, fontSize: 16),),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
    //resumeTimer();
  }

  /// Disposes of resources when the widget is removed from the tree.
  ///
  /// This method cancels the timer to avoid memory leaks when the widget is disposed.
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
