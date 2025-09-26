// lib/quiz.dart
import 'package:flutter/material.dart';

import 'start_screen.dart';
import 'questions_screen.dart';        // <- file is in lib/
import 'models/results_screen.dart';   // <- file is in lib/models/
import 'data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<String> _selectedAnswers = [];
  String _activeScreen = 'start'; // start | questions | results

  void _start() => setState(() => _activeScreen = 'questions');

  void _choose(String answer) {
    _selectedAnswers.add(answer);
    if (_selectedAnswers.length == questions.length) {
      setState(() => _activeScreen = 'results');
    } else {
      setState(() {}); // advance to next question
    }
  }

  void _restart() {
    setState(() {
      _selectedAnswers.clear();
      _activeScreen = 'start';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen = StartScreen(_start);

    if (_activeScreen == 'questions') {
      // ✅ make sure there is NO stray dot or colon here
      screen = QuestionsScreen(onSelectedAnswer: _choose);
    } else if (_activeScreen == 'results') {
      screen = ResultsScreen(
        chosenAnswers: _selectedAnswers,
        onRestart: _restart,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screen,
        ),
      ),
    );
  }
}
