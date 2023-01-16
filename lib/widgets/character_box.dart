import 'package:flutter/material.dart';

class CharacterBox extends StatelessWidget {
  final VoidCallback onTap;
  final bool isCurrentBox;
  final String letter;
  final bool isCorrectGuess;

  const CharacterBox(
      {super.key,
      required this.onTap,
      this.isCurrentBox = false,
      required this.letter,
      required this.isCorrectGuess});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              color: isCorrectGuess ? Colors.limeAccent : Colors.white,
              borderRadius: BorderRadius.circular(4)),
          child: isCorrectGuess
              ? Center(
                  child: Text(
                    letter,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                )
              : null),
    );
  }
}
