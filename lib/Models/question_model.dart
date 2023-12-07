class GameModel{
  final String question;
  final int solution;

  GameModel({
    required this.question,
    required this.solution,
  });

  factory GameModel.fromJson(Map<String, dynamic> json){
    return GameModel(
      question: json["question"],
      solution: json["solution"],
    );
  }
}