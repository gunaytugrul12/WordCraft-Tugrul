import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  final String answerText;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback? onTap;

  const AnswerCard({
    Key? key,
    required this.answerText,
    required this.isSelected,
    required this.isCorrect,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color cardColor = Colors.white;
    if (isSelected) {
      cardColor = isCorrect ? Colors.green : Colors.red;
    }

    return Card(
      color: cardColor,
      child: ListTile(
        title: Text(answerText),
        onTap: onTap,
      ),
    );
  }
}
