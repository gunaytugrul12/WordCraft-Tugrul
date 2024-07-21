import 'package:flutter/material.dart';
import 'package:languagelearningapp/screens/games.dart';


class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        backgroundColor: Colors.black, // German flag color: black
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Animated trophy icon
            Icon(
              Icons.emoji_events,
              color: Colors.amber, // German flag color: yellow
              size: 100.0,
            ),
            SizedBox(height: 20.0),
            // Congratulatory message
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // German flag color: black
              ),
            ),
            SizedBox(height: 20.0),
            // Score display
            Text(
              'Your score is: $score',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.red, // German flag color: red
              ),
            ),
            SizedBox(height: 40.0),
            // Play again button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.refresh),
              label: Text('Play Again'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // German flag color: black
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),
            // Go to games screen button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GamesPage(categoryName: 'Sample Category')),
                );
              },
              icon: Icon(Icons.home),
              label: Text('Go to Games'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // German flag color: red
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
