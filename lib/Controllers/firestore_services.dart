import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/score_model.dart';

/// A service class for interacting with Firestore to manage user scores.
class FirestoreServices{
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('score');
  late ScoreModel scoreModel;

  /// Updates or creates user score data in Firestore.
  ///
  /// Given a userId and score, this method checks if a document with the
  /// specified userId already exists. If the document exists, it compares
  /// the existing score with the provided score and updates it if the new
  /// score is higher. If the document doesn't exist, a new document is created
  /// with the provided userId and score.
  Future<void> updateorCreateData(String userId, int score) async {
    DocumentSnapshot documentSnapshot = await _collectionReference.doc(userId).get();
    //Check if documents exists
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
      //If document doesn't exists
      await _collectionReference.doc(userId).set({
        'score':score,
        'time' : FieldValue.serverTimestamp(),
      });
    }
  }

  /// Retrieves the highest score and the achieved time from Firestore.
  ///
  /// Given a userId, this method retrieves the document from Firestore and extracts the highest score and the time it was achieved. If the document doesn't exist, default values are returned.
  Future<ScoreModel> getHighestScore(String userId) async{
    int highestScore;
    Timestamp timeAchieved;
    DocumentSnapshot documentSnapshot = await _collectionReference.doc(userId).get();
    if(documentSnapshot.exists){
      highestScore=documentSnapshot.get('score');
      timeAchieved=documentSnapshot.get('time');
    } else{
      // Pass default value if doc doesn't exists
      highestScore=0;
      timeAchieved= Timestamp.now();
    }
    return ScoreModel(highestScore: highestScore, timeAchieved: timeAchieved);
  }
}