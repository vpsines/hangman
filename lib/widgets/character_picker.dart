import 'package:flutter/material.dart';
import 'package:hangman/bloc/game_stage_bloc.dart';

class CharacterPicker extends StatefulWidget {
  const CharacterPicker({super.key, required this.gameStageBloc});
  final GameStageBloc gameStageBloc;

  @override
  State<CharacterPicker> createState() => _CharacterPickerState();
}

class _CharacterPickerState extends State<CharacterPicker> {
  var alphabets =
      'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z'.split(",");

  late List<String> guessedLetters;

  @override
  void initState() {
    guessedLetters = [];
    super.initState();
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
                        alphabets.length,
                        (index) => GestureDetector(
                              onTap: () {
                                if (!snapshot.data!
                                    .contains(alphabets[index])) {
                                  guessedLetters.add(alphabets[index]);
                                  widget.gameStageBloc
                                      .updateGuessedCharacters(guessedLetters);

                                  if (!widget
                                      .gameStageBloc.currentGuessWord.value
                                      .contains(alphabets[index])) {
                                    widget.gameStageBloc.updateLostBodyParts();
                                  }
                                }
                              },
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                    color: guessedLetters
                                            .contains(alphabets[index])
                                        ? Colors.grey
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(alphabets[index]),
                                ),
                              ),
                            )),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
