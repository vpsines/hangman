import 'package:flutter/material.dart';
import 'package:hangman/widgets/character_picker.dart';
import 'package:hangman/widgets/hang_man.dart';
import 'package:hangman/widgets/word_puzzle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.red],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HangMan(
              size: size,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CharacterPicker(),
                WordPuzzle(guessWord: "HANGMAN")],
            ))
          ],
        ),
      ),
    );
  }
}
