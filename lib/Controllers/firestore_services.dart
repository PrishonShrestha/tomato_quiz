import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/score_model.dart';

class FirestoreServices{
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('score');
  late ScoreModel scoreModel;

  Future<void> updateorCreateData(String userId, int score) async {
    DocumentSnapshot documentSnapshot = await _collectionReference.doc(userId).get();
    //Documents exists
    if(documentSnapshot.exists){
      print("Doc exists");
      var highestscore = documentSnapshot.get('score');
      if(score>highestscore){
        await _collectionReference.doc(userId).update({
          'score': score,
          'time' : FieldValue.serverTimestamp(),
        });
      }

    } else{
      print("Doc doesn't exists");
      //If document doesn't exists
      await _collectionReference.doc(userId).set({
        'score':score,
        'time' : FieldValue.serverTimestamp(),
      });
    }
  }

  Future<ScoreModel> getHighestScore(String userId) async{
    int highestScore;
    Timestamp timeAchieved;
    DocumentSnapshot documentSnapshot = await _collectionReference.doc(userId).get();
    if(documentSnapshot.exists){
      //highestScore = documentSnapshot.get('score');
      highestScore=documentSnapshot.get('score');
      timeAchieved=documentSnapshot.get('time');
    } else{
      //highestScore=0;
      highestScore=documentSnapshot.get('score');
      timeAchieved=documentSnapshot.get('time');
    }
    return ScoreModel(highestScore: highestScore, timeAchieved: timeAchieved);
  }

}