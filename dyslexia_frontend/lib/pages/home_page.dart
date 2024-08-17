import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add navigation or action here
              },
              child: Text('Button 1'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add navigation or action here
              },
              child: Text('Button 2'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add navigation or action here
              },
              child: Text('Button 3'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add navigation or action here
              },
              child: Text('Button 4'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add navigation or action here
              },
              child: Text('Button 5'),
            ),
          ],
        ),
      ),
    );
  }
}
