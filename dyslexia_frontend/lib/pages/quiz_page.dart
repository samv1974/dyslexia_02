import 'package:dyslexia_frontend/pages/home_page.dart';
import 'package:flutter/material.dart';
import '../data/quiz_data.dart'; 

class QuizPage extends StatefulWidget {
  final String quizType;

  QuizPage({required this.quizType});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentGameIndex = 0;
  int currentQuestionIndex = 0;


  @override
  Widget build(BuildContext context) {
    List<String> currentGameQuestions = quizData[widget.quizType]?[currentGameIndex] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.quizType.capitalize()} Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentGameQuestions[currentQuestionIndex],
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentQuestionIndex++;
                  if (currentQuestionIndex >= currentGameQuestions.length) {
                    currentQuestionIndex = 0;
                    currentGameIndex++;
                    if (currentGameIndex >= quizData[widget.quizType]!.length) {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                    }
                  }
                });
              },
              child: Text('Next Question'),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
