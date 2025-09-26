// lib/models/quiz_question.dart
class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  // Return a shuffled copy of the answers.
  List<String> shuffledAnswers() {
    final list = List<String>.from(answers);
    list.shuffle();
    return list;
  }
}
