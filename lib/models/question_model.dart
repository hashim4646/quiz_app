class QuestionModel {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String category;
  final String explanation;

  const QuestionModel({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.category,
    this.explanation = '',
  });
}
