import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:hangman/utils/guess_word_helper.dart';
import 'package:rxdart/rxdart.dart';

class GameStageBloc {
  /// current state of the game
  ValueNotifier<GameState> currentGameState =
      ValueNotifier<GameState>(GameState.idle);

  /// current guess word
  ValueNotifier<String> currentGuessWord = ValueNotifier<String>('');

  ValueNotifier<List<BodyPart>> lostParts = ValueNotifier<List<BodyPart>>([]);

  var _guessedCharactersController = BehaviorSubject<List<String>>();

  Stream<List<String>> get guessedCharacters =>
      _guessedCharactersController.stream;

  /// to create a new game
  void createNewGame() {
    currentGameState.value = GameState.running;
    lostParts.value.clear();

    var guessWord = GuessWordHelper().generateRandomWord();
    currentGuessWord.value = guessWord;
    _guessedCharactersController.sink.add([]);
  }

  /// checks if user identified the word correctly
  void _checkGame(List<String> guessedCharacters) {
    var allValuesIdentified = true;
    var characters = currentGuessWord.value.split('');

    for (var character in characters) {
      if (!guessedCharacters.contains(character)) {
        allValuesIdentified = false;
        continue;
      }
    }

    if (allValuesIdentified) {
      currentGameState.value = GameState.succeeded;
    }
  }

  /// update guessed characters
  void updateGuessedCharacters(List<String> updatedGuessedCharacters){
    _guessedCharactersController.sink.add(updatedGuessedCharacters);
    _checkGame(updatedGuessedCharacters);
  }

  /// method to update lost body parts of hangman
  void updateLostBodyParts(){
    if(!lostParts.value.contains(BodyPart.head)){
      lostParts.value.add(BodyPart.head);
      return;
    }

    if(!lostParts.value.contains(BodyPart.body)){
      lostParts.value.add(BodyPart.body);
      return;
    }

    if(!lostParts.value.contains(BodyPart.leftLeg)){
      lostParts.value.add(BodyPart.leftLeg);
      return;
    }

    if(!lostParts.value.contains(BodyPart.rightLeg)){
      lostParts.value.add(BodyPart.rightLeg);
      return;
    }

    if(!lostParts.value.contains(BodyPart.leftHand)){
      lostParts.value.add(BodyPart.leftHand);
      return;
    }

    if(!lostParts.value.contains(BodyPart.rightHand)){
      lostParts.value.add(BodyPart.rightHand);
      
      // player has lost all body parts
      currentGameState.value = GameState.failed;
      return;
    }
  }
}

/// states of the game
enum GameState { idle, running, failed, succeeded }

/// body parts of hangman
enum BodyPart { head, body, leftLeg, rightLeg, leftHand, rightHand }
