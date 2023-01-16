import 'dart:html';

import 'package:flutter/foundation.dart';

class GameStageBloc{

  /// current state of the game
  ValueNotifier<GameState> currentGameState = ValueNotifier<GameState>(GameState.idle);

  /// current guess word
  ValueNotifier<String> currentGuessWord = ValueNotifier<String>('');

  ValueNotifier<List<BodyPart>> lostParts = ValueNotifier<List<BodyPart>>();
}

/// states of the game
enum GameState{
  idle,
  running,
  failed,
  succeeded
}

/// body parts of hangman
enum BodyPart{
  head,
  body,
  leftLeg,
  rightLeg,
  leftHand,
  rightHand
}