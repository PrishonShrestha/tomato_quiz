
import 'package:cloud_firestore/cloud_firestore.dart';

/// A model class representing a user's highest score and the time it was achieved.
class ScoreModel{
  int highestScore;
  Timestamp timeAchieved;

  /// Creates a ScoreModel with the specified highestScore and timeAchieved.
  ScoreModel({
    required this.highestScore,
    required this.timeAchieved,
  });
}