import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'answer_button.dart';
import 'data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectedAnswer});
  final void Function(String answer) onSelectedAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectedAnswer(selectedAnswer);
    setState(() => currentQuestionIndex++);
  }

  @override
  Widget build(BuildContext context) {
    final safeIndex =
    currentQuestionIndex.clamp(0, questions.length - 1).toInt();
    final currentQuestion = questions[safeIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 219, 133, 215),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ...currentQuestion.shuffledAnswers().map(
                  (answer) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: AnswerButton(
                  answerText: answer,
                  onTap: () => answerQuestion(answer),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
