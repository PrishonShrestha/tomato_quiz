import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreModel{
  int highestScore;
  Timestamp timeAchieved;

  ScoreModel({
    required this.highestScore,
    required this.timeAchieved,
  });
}