import 'package:flutter/material.dart';
import 'package:hangman/widgets/character_box.dart';

class WordPuzzle extends StatefulWidget {
  final String guessWord;

  const WordPuzzle({super.key, required this.guessWord});

  @override
  State<WordPuzzle> createState() => _WordPuzzleState();
}

class _WordPuzzleState extends State<WordPuzzle> {
  int _selectedBoxIndex = 0;

  void updateSelectedBoxIndex(int index) {
    setState(() {
      _selectedBoxIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
            widget.guessWord.length,
            (index) => CharacterBox(
                  onTap: () {
                    updateSelectedBoxIndex(index);
                  },
                  isCurrentBox: index == _selectedBoxIndex,
                )),
      ),
    );
  }
}
