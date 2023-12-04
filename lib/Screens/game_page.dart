import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_tomato/Controllers/game_controller.dart';
import 'package:game_tomato/Screens/home_page.dart';
import 'package:game_tomato/Services/FirestoreServices.dart';
import 'package:http/http.dart' as http;

import '../Models/game_model.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late GameModel gameModel;
  static int currentTotalScore = 0;
  List<int> optionsList =[];
  Random random = new Random();

  GameController gameController = new GameController();
  
  final firestoreServices = FirestoreServices();

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    currentTotalScore=0;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Tomato game"),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          color: Colors.white,

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
                          //image: NetworkImage("https://clipart-library.com/img1/1728611.jpg",),
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
                          gameModel.question,
                          //"https://t4.ftcdn.net/jpg/05/69/98/21/360_F_569982133_DzhJ6XJglSrBEqK6dS7cTdUxD5iWotoD.jpg",
                          height: size.height*0.2,
                          width: size.width*0.65,
                          fit: BoxFit.fill,
                        ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text("Current score: " + currentTotalScore.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        //gameController.checkAnswer(optionsList[0], sol!,);
                        checkAns(gameModel.solution, optionsList[0]);
                      },
                      child: Container(
                          height: 50,
                          width: 80,
                          child: Center(
                              child: Text(
                                optionsList[0].toString(),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              )
                          )
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        //gameController.checkAnswer(optionsList[1], sol!,);
                        checkAns(gameModel.solution, optionsList[1]);
                      },
                      child: Container(
                          height: 50,
                          width: 80,
                          child: Center(
                              child: Text(
                                optionsList[1].toString(),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              )
                          )
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        //gameController.checkAnswer(optionsList[2], sol!,);
                        checkAns(gameModel.solution, optionsList[2]);
                      },
                      child: Container(
                          height: 50,
                          width: 80,
                          child: Center(
                              child: Text(
                                optionsList[2].toString(),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              )
                          )
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        //gameController.checkAnswer(optionsList[3], sol!,);
                        checkAns(gameModel.solution, optionsList[3]);
                      },
                      child: Container(
                          height: 50,
                          width: 80,
                          child: Center(
                              child: Text(
                                optionsList[3].toString(),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
  }

  void checkAns(int correctAns, int userAns){
    if( userAns == correctAns ){
      currentTotalScore = currentTotalScore+10;
      fetchData();
    } else{
      firestoreServices.updateorCreateData(user!.uid, currentTotalScore);
      alertDialog(context as BuildContext);

     /*
      showDialog(
          context: context,
          builder: (BuildContext builder){
            return Center(
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
                      Text("Oops! Wrong answer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, decoration: TextDecoration.none, color: Colors.red),),
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
                                //Navigator.of(context, rootNavigator: true).pop(context);
                                Navigator.of(context).pop();
                                fetchData();
                                currentTotalScore=0;
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
                                MaterialPageRoute(builder: (context) => const HomePage()),
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
            );
          }
      );
      resumeTimer();*/
    }
  }

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
    generateOptions(gameModel.solution);
  }

  Future<dynamic> alertDialog(BuildContext context) async {
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
                      Text("Oops! Wrong answer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, decoration: TextDecoration.none, color: Colors.red),),
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

}
