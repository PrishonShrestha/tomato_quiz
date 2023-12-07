/// A model class representing a game question and its solution.
class GameModel{
  final String question;
  final int solution;

  /// Creates a GameModel with the specified [question] and [solution].
  GameModel({
    required this.question,
    required this.solution,
  });

  /// Factory method to create a GameModel instance from a JSON map.
  ///
  /// The json map should contain keys "question" for the question text
  /// and "solution" for the solution value.
  factory GameModel.fromJson(Map<String, dynamic> json){
    return GameModel(
      question: json["question"],
      solution: json["solution"],
    );
  }
}