import 'package:flutter/material.dart';
import 'package:hangman/bloc/game_stage_bloc.dart';
import 'package:hangman/widgets/character_picker.dart';
import 'package:hangman/widgets/hang_man.dart';
import 'package:hangman/widgets/word_puzzle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GameStageBloc gameStageBloc;

  @override
  void initState() {
    gameStageBloc = GameStageBloc();
    super.initState();
  }

  @override
  void dispose() {
    gameStageBloc.dispose();
    super.dispose();
  }

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
              gameStageBloc: gameStageBloc,
              size: size,
            ),
            Expanded(
              child: Container(
                child: ValueListenableBuilder(
                    valueListenable: gameStageBloc.currentGuessWord,
                    builder: ((context, guessWord, child) {
                      return (guessWord == null || guessWord.isEmpty)
                          ? Center(
                              child: ElevatedButton(
                                child: const Text("Start New Game"),
                                onPressed: () {
                                  gameStageBloc.createNewGame();
                                },
                              ),
                            )
                          : ValueListenableBuilder(
                              valueListenable: gameStageBloc.currentGameState,
                              builder: ((context, gameState, child) {
                                return (gameState == GameState.succeeded)
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Bravo! Yo got it champ.",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24),
                                          ),
                                          ElevatedButton(
                                            child: const Text("Start New Game"),
                                            onPressed: () {
                                              gameStageBloc.createNewGame();
                                            },
                                          ),
                                        ],
                                      )
                                    : (gameState == GameState.failed)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Oops, you failed!",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              RichText(
                                                  text: TextSpan(children: [
                                                const TextSpan(
                                                  text:
                                                      "The correct word was: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24),
                                                ),
                                                TextSpan(
                                                  text: gameStageBloc
                                                      .currentGuessWord.value,
                                                  style: const TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24),
                                                ),
                                              ])),
                                              ElevatedButton(
                                                child: const Text(
                                                    "Start New Game"),
                                                onPressed: () {
                                                  gameStageBloc.createNewGame();
                                                },
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Guess the correct district...",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        gameStageBloc
                                                            .createNewGame();
                                                      },
                                                      icon: const Icon(
                                                        Icons.restore,
                                                        color: Colors.white,
                                                        size: 24,
                                                      ))
                                                ],
                                              ),
                                              CharacterPicker(
                                                gameStageBloc: gameStageBloc,
                                              ),
                                              WordPuzzle(
                                                guessWord: guessWord,
                                                gameStageBloc: gameStageBloc,
                                              )
                                            ],
                                          );
                              }));
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
