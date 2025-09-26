import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  // Each map: question_index (int), question (String), user_answer (String), correct_answer (String)
  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            final index = data['question_index'] as int;
            final question = data['question'] as String;
            final userAnswer = data['user_answer'] as String;
            final correctAnswer = data['correct_answer'] as String;
            final isCorrect = userAnswer == correctAnswer;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: isCorrect ? Colors.green : Colors.red,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(question,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        Text('Your answer: $userAnswer',
                            style: TextStyle(
                                color: isCorrect ? Colors.greenAccent : const Color(0xFFFFB4A9))),
                        Text('Correct answer: $correctAnswer',
                            style: const TextStyle(color: Color(0xFFBDE0FE))),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
