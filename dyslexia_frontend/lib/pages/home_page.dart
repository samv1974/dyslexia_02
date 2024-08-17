import 'package:flutter/material.dart';
import 'quiz_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dyslexia Prediction App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QuizButton(
              text: 'Audio Quiz',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage(quizType: 'audio')),
              ),
            ),
            QuizButton(
              text: 'Visual Quiz',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage(quizType: 'visual')),
              ),
            ),
            QuizButton(
              text: 'Speed Quiz',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage(quizType: 'speed')),
              ),
            ),
            QuizButton(
              text: 'Memory Quiz',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage(quizType: 'memory')),
              ),
            ),
            QuizButton(
              text: 'Language Quiz',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage(quizType: 'language')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  QuizButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(200, 50),
        ),
      ),
    );
  }
}
