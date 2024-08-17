import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../data/quiz_data.dart';

class AudioGame1 extends StatelessWidget {
  final int questionIndex;

  AudioGame1({required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    //List<string> questions = quizData['audio'][0];
    List<List<String>> questions = [
      ["assets/audio_Game1_1_Cat.png", "Cat", "assets/audio_Game1_1_Bat.png", "Bat"],
      ["assets/audio_Game1_2_Wall.png", "Wall", "assets/audio_Game1_2_Ball.png", "Ball"],
      ["assets/audio_Game1_3_Man.png", "Man", "assets/audio_Game1_3_Fan.png", "Fan"],
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 0.5,
            child: Image.asset(questions[questionIndex][0])),
          Text(
            questions[questionIndex][1],
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Transform.scale(
            scale: 0.5,
            child: Image.asset(questions[questionIndex][2])),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter the label for the second image',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle answer submission or proceed to the next question
              // (Next question handling will be done in quiz_page.dart)
            },
            child: Text('Submit Answer'),
          ),
        ],
      ),
    );
  }
}
