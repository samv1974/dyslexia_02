



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../data/quiz_data.dart';

class VisualGame1 extends StatelessWidget {
  final List<List<String>> questions;
  final Function(double score) onGameCompleted;

  VisualGame1({required this.questions, required this.onGameCompleted,});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("visual_game1")
        ],
      ),
    );
  }
}


