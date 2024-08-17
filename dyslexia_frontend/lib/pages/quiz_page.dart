import 'package:dyslexia_frontend/pages/home_page.dart';
import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../games/audio/audio_Game1.dart';
import '../games/audio/audio_Game2.dart';
import '../games/audio/audio_Game3.dart';
// Similarly, import other game files for visual, speed, memory, and language

class QuizPage extends StatefulWidget {
  final String quizType;

  QuizPage({required this.quizType});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentGameIndex = 0;
  int currentQuestionIndex = 0;

  Widget _getGameWidget(String quizType, int gameIndex) {
    switch (quizType) {
      case 'audio':
        switch (gameIndex) {
          case 0:
            return AudioGame1(questionIndex: currentQuestionIndex);
          case 1:
            return AudioGame2(questionIndex: currentQuestionIndex);
          case 2:
            return AudioGame3(questionIndex: currentQuestionIndex);
          // Add more cases for other quiz types
        }
        break;
      case 'visual':
        switch (gameIndex) {
          case 0:
            return AudioGame1(questionIndex: currentQuestionIndex);
          case 1:
            return AudioGame2(questionIndex: currentQuestionIndex);
          case 2:
            return AudioGame3(questionIndex: currentQuestionIndex);
          // Add more cases for other quiz types
        }
        break;
      case 'speed':
        switch (gameIndex) {
          case 0:
            return AudioGame1(questionIndex: currentQuestionIndex);
          case 1:
            return AudioGame2(questionIndex: currentQuestionIndex);
          case 2:
            return AudioGame3(questionIndex: currentQuestionIndex);
          // Add more cases for other quiz types
        }
        break;
      case 'memory':
        switch (gameIndex) {
          case 0:
            return AudioGame1(questionIndex: currentQuestionIndex);
          case 1:
            return AudioGame2(questionIndex: currentQuestionIndex);
          case 2:
            return AudioGame3(questionIndex: currentQuestionIndex);
          // Add more cases for other quiz types
        }
        break;
      case 'language':
        switch (gameIndex) {
          case 0:
            return AudioGame1(questionIndex: currentQuestionIndex);
          case 1:
            return AudioGame2(questionIndex: currentQuestionIndex);
          case 2:
            return AudioGame3(questionIndex: currentQuestionIndex);
          // Add more cases for other quiz types
        }
        break;
    }
    return Container(); // Fallback, in case no game is found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.quizType.capitalize()} Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: _getGameWidget(widget.quizType, currentGameIndex)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentQuestionIndex++;
                  if (currentQuestionIndex >= quizData[widget.quizType]![currentGameIndex].length) {
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
