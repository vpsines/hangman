import 'package:flutter/material.dart';
import 'package:hangman/bloc/game_stage_bloc.dart';
import 'package:hangman/widgets/character_box.dart';

class WordPuzzle extends StatefulWidget {
  final String guessWord;
  final GameStageBloc gameStageBloc;

  const WordPuzzle(
      {super.key, required this.guessWord, required this.gameStageBloc});

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
    return StreamBuilder(
      stream: widget.gameStageBloc.guessedCharacters,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        return (snapshot.hasData)
            ? Container(
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
                            letter: widget.guessWord[index],
                            isCorrectGuess: snapshot.data!
                                .contains(widget.guessWord[index]),
                          )),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
