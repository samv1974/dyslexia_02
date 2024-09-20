import 'package:dyslexia_frontend/games/language/language_Game1.dart';
import 'package:dyslexia_frontend/games/language/language_Game2.dart';
import 'package:dyslexia_frontend/games/language/language_Game3.dart';
import 'package:dyslexia_frontend/games/memory/memory_Game1.dart';
import 'package:dyslexia_frontend/games/memory/memory_Game2.dart';
import 'package:dyslexia_frontend/games/memory/memory_Game3.dart';
import 'package:dyslexia_frontend/games/speed/speed_Game1.dart';
import 'package:dyslexia_frontend/games/speed/speed_Game2.dart';
import 'package:dyslexia_frontend/games/speed/speed_Game3.dart';
import 'package:dyslexia_frontend/games/visual/visual_Game1.dart';
import 'package:dyslexia_frontend/games/visual/visual_Game2.dart';
import 'package:dyslexia_frontend/games/visual/visual_Game3.dart';
import 'package:dyslexia_frontend/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../games/audio/audio_Game1.dart';
import '../games/audio/audio_Game2.dart';
import '../games/audio/audio_Game3.dart';
import 'dart:convert';

class QuizPage extends StatefulWidget {
  final String quizType;

  QuizPage({required this.quizType});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentGameIndex = 0;
  int currentQuestionIndex = 0; // Track the current question index
  dynamic questions;
  
  Map<String, double> scores = {};  // Store scores for all games in the quiz

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    //UPDATE THIS FUNCTION AFTER ALL GAMES ARE MADE
    final String url = 'http://127.0.0.1:8000/questions';  // Example URL, replace with your actual backend endpoint
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        questions = json.decode(response.body)['audio_quiz'];  // Load questions for the specific quiz type
        
      });
    } else {
      // Handle error
      print('Failed to load questions');
    }
  }

  // This function will send the scores once the entire quiz (all games) is completed
  Future<void> _submitQuizScore() async {
    print("scores are:");
    print(scores);
    final String url = 'http://127.0.0.1:8000/submit_score';  // Replace with your actual backend endpoint

    // Construct the payload with the quiz type and accumulated scores
    final Map<String, dynamic> scoreData = {
      "uid": "002",
      "type": widget.quizType,
      "${widget.quizType}Quiz": scores,
    };
     
    print("scoreData: $scoreData");
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(scoreData),
    );

    if (response.statusCode == 200) {
      print(scoreData);
      print("Score submitted successfully");
    } else {
      print("Failed to submit score");
    }
  }

  int _getQuizType() {
    // Map quiz types to their respective numerical values
    switch (widget.quizType) {
      case 'audio':
        return 1;
      case 'visual':
        return 2;
      case 'speed':
        return 3;
      case 'memory':
        return 4;
      case 'language':
        return 5;
      default:
        return 0;  // Unknown quiz type
    }
  }

  Widget _getGameWidget(int gameIndex) {
    if (questions == null) {
      return Center(child: CircularProgressIndicator());
    }

    switch (widget.quizType) {
      case 'audio':
        return _getAudioGameWidget(gameIndex);
      case 'visual':
        return _getVisualGameWidget(gameIndex);
      case 'speed':
        return _getSpeedGameWidget(gameIndex);
      case 'memory':
        return _getMemoryGameWidget(gameIndex);
      case 'language':
        return _getLanguageGameWidget(gameIndex);
    }
    return Container(); // Fallback if no game is found
  }

  Widget _getAudioGameWidget(int gameIndex) {
    switch (gameIndex) {
      case 0:
        return AudioGame1(
          questions: questions['audio_game1'],  
          onGameCompleted: (double score) {
            setState(() {
              scores['audio_game1'] = score;  // Store score for audio_game1
            });
          },
        );
      case 1:
        return AudioGame2(
          questions: questions['audio_game1'],   //CHANGE IT AFTER ALL THREE GAMES ARE DONE
          onGameCompleted: (double score) {
            setState(() {
              scores['audio_game2'] = score;  // Store score for audio_game2
            });
          },
        );
      case 2:
        return AudioGame3(
          questions: questions['audio_game1'],   //CHANGE IT AFTER ALL THREE GAMES ARE DONE
          onGameCompleted: (double score) {
            setState(() {
              scores['audio_game3'] = score;  // Store score for audio_game3
            });
          },
        );
    }
    return Container();
  }

  Widget _getVisualGameWidget(int gameIndex) {
    switch (gameIndex) {
      case 0:
        return VisualGame1(
          questions: questions['visual_game1'],
          onGameCompleted: (double score) {
            setState(() {
              scores['visual_game1'] = score;  // Store score for visual_game1
            });
          },
        );
      case 1:
        return VisualGame2(
          questions: questions['visual_game2'],
          onGameCompleted: (double score) {
            setState(() {
              scores['visual_game2'] = score;  // Store score for visual_game2
            });
          },
        );
      case 2:
        return VisualGame3(
          questions: questions['visual_game3'],
          onGameCompleted: (double score) {
            setState(() {
              scores['visual_game3'] = score;  // Store score for visual_game3
            });
          },
        );
    }
    return Container();
  }

  Widget _getSpeedGameWidget(int gameIndex) {
    switch (gameIndex) {
      case 0:
        return SpeedGame1(
          questions: questions['speed_game1'],
          onGameCompleted: (double score) {
            setState(() {
              scores['speed_game1'] = score;  // Store score for speed_game1
            });
          },
        );
      case 1:
        return SpeedGame2(
          questions: questions['speed_game2'],
          onGameCompleted: (double score) {
            setState(() {
              scores['speed_game2'] = score;  // Store score for speed_game2
            });
          },
        );
      case 2:
        return SpeedGame3(
          questions: questions['speed_game3'],
          onGameCompleted: (double score) {
            setState(() {
              scores['speed_game3'] = score;  // Store score for speed_game3
            });
          },
        );
    }
    return Container();
  }

  Widget _getMemoryGameWidget(int gameIndex) {
    switch (gameIndex) {
      case 0:
        return MemoryGame1(
          questions: questions['memory_game1'],
          onGameCompleted: (double score) {
            setState(() {
              scores['memory_game1'] = score;  // Store score for memory_game1
            });
          },
        );
      case 1:
        return MemoryGame2(
          questions: questions['memory_game2'],
          onGameCompleted: (double score) {
            setState(() {
              scores['memory_game2'] = score;  // Store score for memory_game2
            });
          },
        );
      case 2:
        return MemoryGame3(
          questions: questions['memory_game3'],
          onGameCompleted: (double score) {
            setState(() {
              scores['memory_game3'] = score;  // Store score for memory_game3
            });
          },
        );
    }
    return Container();
  }

  Widget _getLanguageGameWidget(int gameIndex) {
    switch (gameIndex) {
      case 0:
        return LanguageGame1(
          questions: questions['language_game1'],
          onGameCompleted: (double score) {
                      setState(() {
            scores['language_game1'] = score;  // Store score for language_game1
          });
        },
      );
    case 1:
      return LanguageGame2(
        questions: questions['language_game2'],
        onGameCompleted: (double score) {
          setState(() {
            scores['language_game2'] = score;  // Store score for language_game2
          });
        },
      );
    case 2:
      return LanguageGame3(
        questions: questions['language_game3'],
        onGameCompleted: (double score) {
          setState(() {
            scores['language_game3'] = score;  // Store score for language_game3
          });
        },
      );
    default:
      return Container();
  }
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

                // Check if all questions for the current game are completed
                

                  // Check if all games for the quiz are completed
                  if (currentGameIndex >= 2) {
                    // Post the score for the entire quiz
                    
                    _submitQuizScore();
                    

                    // Navigate to the home page after the quiz is completed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    // Load the next game
                    _fetchQuestions();
                    currentGameIndex++;
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

