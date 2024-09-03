import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:string_similarity/string_similarity.dart';
import 'dart:convert';

class AudioGame1 extends StatelessWidget {
  final int questionIndex;
  final Map<String, dynamic> questions;

  AudioGame1({required this.questionIndex, required this.questions});

  final TextEditingController _controller = TextEditingController();

  Future<void> _postScore(double similarityScore) async {
    final String apiUrl = 'https://127.0.0.1/post_audioGame1'; // Replace with your backend URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'questionIndex': questionIndex,
          'similarityScore': similarityScore,
          'userId': 'user-id-here', // Include user ID if necessary
        }),
      );

      if (response.statusCode == 200) {
        print('Score submitted successfully');
      } else {
        print('Failed to submit score: ${response.statusCode}');
      }
    } catch (error) {
      print('Error submitting score: $error');
    }
  }

  void _checkAnswer(BuildContext context) async {
    String userAnswer = _controller.text.trim();
    String correctAnswer = questions['answer'] ?? '';

    double similarity = userAnswer.similarityTo(correctAnswer);

    await _postScore(similarity);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Answer Result'),
          content: Text(
            similarity >= 0.8
                ? 'Correct! Similarity score: ${(similarity * 100).toStringAsFixed(2)}%'
                : 'Try again! Similarity score: ${(similarity * 100).toStringAsFixed(2)}%',
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _controller.clear();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Extract data from the JSON structure based on your backend's format.
    final String? img1Url = questions['img1'];
    final String? label1 = questions['label1'];
    final String? img2Url = questions['img2'];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (img1Url != null)
            Transform.scale(
              scale: 0.5,
              child: Image.network(img1Url),
            ),
          if (label1 != null)
            Text(
              label1,
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          SizedBox(height: 20),
          if (img2Url != null)
            Transform.scale(
              scale: 0.5,
              child: Image.network(img2Url),
            ),
          SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter the label for the second image',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _checkAnswer(context);
            },
            child: Text('Submit Answer'),
          ),
        ],
      ),
    );
  }
}
