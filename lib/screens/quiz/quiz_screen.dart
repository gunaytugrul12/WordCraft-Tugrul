import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'answer_card.dart'; // Import the AnswerCard widget
import 'result_screen.dart'; // Import the ResultScreen

class QuizScreen extends StatefulWidget {
  final String collectionName;

  const QuizScreen({Key? key, required this.collectionName}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool isLoading = true;
  int? selectedAnswerIndex;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(widget.collectionName)
          .get();
      setState(() {
        questions = querySnapshot.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          return Question(
            questionText: data['questionText'] ?? 'No question text',
            options: List<String>.from(data['options'] ?? []),
            correctAnswerIndex: data['correctAnswerIndex'] ?? 0,
            imageUrl: data['imageUrl'] ?? '',
          );
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void _answerQuestion(int answerIndex) {
    setState(() {
      selectedAnswerIndex = answerIndex;
    });

    Future.delayed(Duration(seconds: 1), () {
      if (questions[currentQuestionIndex].correctAnswerIndex == answerIndex) {
        setState(() {
          score++;
        });
      }

      setState(() {
        selectedAnswerIndex = null;
        if (currentQuestionIndex < questions.length - 1) {
          currentQuestionIndex++;
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ResultScreen(score: score)),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              questions[currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            if (questions[currentQuestionIndex].imageUrl.isNotEmpty)
              Image.network(questions[currentQuestionIndex].imageUrl),
            SizedBox(height: 20.0),
            ...questions[currentQuestionIndex].options.map((option) {
              int index = questions[currentQuestionIndex].options.indexOf(option);
              return AnswerCard(
                answerText: option,
                isSelected: selectedAnswerIndex == index,
                isCorrect: index == questions[currentQuestionIndex].correctAnswerIndex,
                onTap: selectedAnswerIndex == null ? () => _answerQuestion(index) : null,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String imageUrl;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.imageUrl,
  });
}
