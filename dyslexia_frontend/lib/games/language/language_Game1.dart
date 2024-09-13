




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../data/quiz_data.dart';

class LanguageGame1 extends StatelessWidget {
  final int questionIndex;
  final List<List<String>> questions;
  final Function(double score) onGameCompleted;

  LanguageGame1({required this.questionIndex, required this.questions, required this.onGameCompleted,});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 0.5,
            child: Image.network(questions[questionIndex][0])),
          Text(
            questions[questionIndex][1],
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Transform.scale(
            scale: 0.5,
            child: Image.network(questions[questionIndex][2])),
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
              onGameCompleted(0.12 * 100);
            },
            child: Text('Submit Answer'),
          ),
        ],
      ),
    );
  }
}




