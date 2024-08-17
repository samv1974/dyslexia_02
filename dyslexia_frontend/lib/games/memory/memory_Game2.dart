import 'package:flutter/material.dart';
import '../../data/quiz_data.dart';

class MemoryGame2 extends StatelessWidget {
  final int questionIndex;

  MemoryGame2({required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    // Fetch the questions for the first game type (index 0) in the audio quiz
    List<String> questions = quizData['memory']![1];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display the current question
        Text(
          questions[questionIndex],
          style: TextStyle(fontSize: 18.0),
          textAlign: TextAlign.center,
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
    );
  }
}
