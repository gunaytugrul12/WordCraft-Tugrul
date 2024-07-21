import 'package:flutter/material.dart';
import 'package:languagelearningapp/screens/flashcard/flashcardScreen.dart';
import 'package:languagelearningapp/screens/games.dart';
import 'package:languagelearningapp/screens/home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int totalQuestions;
  final String collectionName;

  const ResultScreen({
    Key? key,
    required this.totalQuestions,
    required this.collectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.deepOrange, // German flag color: black
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo1.png',
                height: 80,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total Questions: $totalQuestions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.refresh),
                  label: Text('Retry'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FlashcardScreen(collectionName: collectionName)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red, // German flag color: red
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    textStyle: TextStyle(fontSize: 18.0),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.games),
                  label: Text('Games'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamesPage(categoryName: collectionName)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.yellow[700], // German flag color: yellow
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    textStyle: TextStyle(fontSize: 18.0),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black, // German flag color: black
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    textStyle: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
