
import 'package:flutter/material.dart';

class GameController {
  Future<void> checkAnswer(int userAnswer, int correctAnswer) async {
    if(userAnswer == correctAnswer){
      print("Correct");
      /*showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text('You guessed the correct number: $correctAnswer'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Play Again'),
                onPressed: () {
                  //generateOptions();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );*/
    } else {
      print("Incorrect");
    }
  }
}