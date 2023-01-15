import 'package:flutter/material.dart';

class CharacterPicker extends StatefulWidget {
  const CharacterPicker({super.key});

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
    return Container(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
            alphabets.length,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      guessedLetters.add(alphabets[index]);
                    });
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: guessedLetters.contains(alphabets[index])
                            ? Colors.grey
                            : Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Text(alphabets[index]),
                    ),
                  ),
                )),
      ),
    );
  }
}
