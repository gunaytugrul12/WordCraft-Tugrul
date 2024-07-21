import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addQuizQuestionToFirestore(
  String questionText,
  List<String> options,
  int correctAnswerIndex,
  String imageUrl
) async {
  try {
    await FirebaseFirestore.instance.collection('quizQuestions').add({
      'questionText': questionText,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'imageUrl': imageUrl,  // Ensure this field matches your Firestore document structure
    });
  } catch (e) {
    print("Error adding question to Firestore: $e");
  }
}
