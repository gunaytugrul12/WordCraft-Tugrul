import 'package:flutter/material.dart';
import 'package:languagelearningapp/screens/games.dart';
import 'package:languagelearningapp/screens/home_screen.dart';
import 'package:languagelearningapp/screens/quizartikel/quizartikelScreen.dart';

class ResultScreen extends StatelessWidget {
  final VoidCallback onReset;
  final String collectionName;
  final int correctAnswers;
  final int totalQuestions;

  const ResultScreen({
    Key? key,
    required this.onReset,
    required this.collectionName,
    required this.correctAnswers,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String feedback;
    Color feedbackColor;

    if (correctAnswers > 10) {
      feedback = "Excellent!";
      feedbackColor = Colors.green;
    } else if (correctAnswers > 7) {
      feedback = "Great!";
      feedbackColor = Colors.yellow[700]!;
    } else if (correctAnswers > 5) {
      feedback = "Not bad!";
      feedbackColor = Colors.orange;
    } else {
      feedback = "Keep trying!";
      feedbackColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Result',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black, // German flag color: black
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events,
              color: Colors.amber, // German flag color: yellow
              size: 100.0,
            ),
            SizedBox(height: 20),
            Text(
              'You got $correctAnswers out of $totalQuestions correct!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              feedback,
              style: TextStyle(fontSize: 24, color: feedbackColor),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuizArtikelScreen(collectionName: collectionName)),
                );
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
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GamesPage(categoryName: collectionName)),
                );
              },
              icon: Icon(Icons.games),
              label: Text('Go to Games'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // German flag color: red
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              icon: Icon(Icons.home),
              label: Text('Go to Home'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.yellow[700], // German flag color: yellow
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
