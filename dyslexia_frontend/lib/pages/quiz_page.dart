import 'package:dyslexia_frontend/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../games/audio/audio_Game1.dart';
import '../games/audio/audio_Game2.dart';
import '../games/audio/audio_Game3.dart';
import 'dart:convert';
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
  List<List<String>> questions = [];

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    final String url = 'https://your-backend-url/${widget.quizType}_Game${currentGameIndex + 1}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        questions = List<List<String>>.from(json.decode(response.body));
      });
    } else {
      // Handle error
      print('Failed to load questions');
    }
  }

  Widget _getGameWidget(int gameIndex) {
    if (questions.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    switch (widget.quizType) {
      case 'audio':
        switch (gameIndex) {
          case 0:
            return AudioGame1(questionIndex: currentQuestionIndex, questions: questions);
          case 1:
            return AudioGame2(questionIndex: currentQuestionIndex, questions: questions);
          case 2:
            return AudioGame3(questionIndex: currentQuestionIndex, questions: questions);
          // Add more cases for other quiz types
        }
        break;
      case 'visual':
        switch (gameIndex) {
          case 0:
            return AudioGame1(questionIndex: currentQuestionIndex, questions: questions);
          case 1:
            return AudioGame2(questionIndex: currentQuestionIndex, questions: questions);
          case 2:
            return AudioGame3(questionIndex: currentQuestionIndex, questions: questions);
          // Add more cases for other quiz types
        }
        break;
      case 'speed':
        switch (gameIndex) {
          case 0:
            return AudioGame1(questionIndex: currentQuestionIndex, questions: questions);
          case 1:
            return AudioGame2(questionIndex: currentQuestionIndex, questions: questions);
          case 2:
            return AudioGame3(questionIndex: currentQuestionIndex, questions: questions);
          // Add more cases for other quiz types
        }
        break;
      case 'memory':
        switch (gameIndex) {
          case 0:
            return AudioGame1(questionIndex: currentQuestionIndex, questions: questions);
          case 1:
            return AudioGame2(questionIndex: currentQuestionIndex, questions: questions);
          case 2:
            return AudioGame3(questionIndex: currentQuestionIndex, questions: questions);
          // Add more cases for other quiz types
        }
        break;
      case 'language':
        switch (gameIndex) {
          case 0:
            return AudioGame1(questionIndex: currentQuestionIndex, questions: questions);
          case 1:
            return AudioGame2(questionIndex: currentQuestionIndex, questions: questions);
          case 2:
            return AudioGame3(questionIndex: currentQuestionIndex, questions: questions);
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
            Expanded(child: _getGameWidget(currentGameIndex)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentQuestionIndex++;
                  if (currentQuestionIndex >= questions.length) {
                    currentQuestionIndex = 0;
                    currentGameIndex++;
                    if (currentGameIndex >= 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      _fetchQuestions();
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