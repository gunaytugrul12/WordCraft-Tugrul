import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:languagelearningapp/screens/quizartikel/result_screen.dart';

class QuizArtikelScreen extends StatefulWidget {
  final String collectionName;

  const QuizArtikelScreen({Key? key, required this.collectionName}) : super(key: key);

  @override
  _QuizArtikelScreenState createState() => _QuizArtikelScreenState();
}

class _QuizArtikelScreenState extends State<QuizArtikelScreen> {
  final List<Map<String, String>> vocabularyList = [];
  String? selectedArticle;
  int correctAnswers = 0;
  int totalQuestions = 0;

  @override
  void initState() {
    super.initState();
    getDataFromFirestore();
  }

  void getDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(widget.collectionName)
          .get();

      setState(() {
        vocabularyList.clear();
        querySnapshot.docs.forEach((doc) {
          final data = doc.data() as Map<String, dynamic>?; // Ensure the data is a map
          print('Doc data: $data'); // Log document data
          // Check if required fields exist
          if (data != null && data.containsKey('word') && data.containsKey('article')) {
            vocabularyList.add({
              'word': data['word'] as String,
              'article': data['article'] as String,
            });
          } else {
            print('Skipping document due to missing fields: ${doc.id}');
          }
        });
        totalQuestions = vocabularyList.length;
        print('Total Questions: $totalQuestions'); // Log total number of questions
      });

      if (vocabularyList.isNotEmpty) {
        pickRandomWord();
      } else {
        print('No valid documents found in the collection.');
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
    }
  }

  void pickRandomWord() {
    setState(() {
      selectedArticle = null;
    });
  }

  void checkAnswer(String article) {
    setState(() {
      selectedArticle = article;
    });

    Future.delayed(Duration(seconds: 1), () {
      if (vocabularyList.isNotEmpty) {
        String correctArticle = vocabularyList[0]['article'] ?? '';
        bool answeredCorrectly = (article == correctArticle);

        if (answeredCorrectly) {
          setState(() {
            correctAnswers++;
          });
        }

        vocabularyList.removeAt(0);
        print('Remaining Questions: ${vocabularyList.length}'); // Log remaining questions
        pickRandomWord();

        if (vocabularyList.isEmpty) {
          navigateToResultScreen();
        }
      }
    });
  }

  void navigateToResultScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          collectionName: widget.collectionName,
          correctAnswers: correctAnswers,
          totalQuestions: totalQuestions,
          onReset: () {
            Navigator.of(context).pop();
            getDataFromFirestore();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo1.png',
              height: 40, // Adjust the height as needed
            ),
            SizedBox(width: 10),
            Text('Quiz',style: TextStyle(color: Colors.white),),
          ],
        ),
        backgroundColor: Colors.deepOrange, // German flag color: black
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: vocabularyList.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Question',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      vocabularyList[0]['word'] ?? '',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: (totalQuestions - vocabularyList.length) / totalQuestions,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red), // German flag color: red
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: ['Das', 'Die', 'Der'].map((article) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(article),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: selectedArticle == article
                                ? (article == vocabularyList[0]['article']
                                    ? Colors.green
                                    : Colors.red)
                                : Colors.black, // German flag color: yellow
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                          ),
                          child: Text(article),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  
                ],
              )
            : Center(
                child: Text(
                  'No questions available',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
