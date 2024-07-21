import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String imageUrl;
  final int correctAnswerIndex;
  final List<String> options;

  Question({
    required this.imageUrl,
    required this.correctAnswerIndex,
    required this.options,
  });

  factory Question.fromDocument(DocumentSnapshot doc) {
    return Question(
      imageUrl: doc['imageUrl'],
      correctAnswerIndex: doc['correctAnswerIndex'],
      options: List<String>.from(doc['options']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'correctAnswerIndex': correctAnswerIndex,
      'options': options,
    };
  }
}
