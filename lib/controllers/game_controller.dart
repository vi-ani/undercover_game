import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/game_state.dart';
import '../models/enums.dart';
import '../models/player.dart';

class GameController extends ChangeNotifier {
  final GameState state = GameState();

  // ----- SETUP -----
  void createPlayers(List<String> names) {
    state.players = names
        .map((n) => Player(name: (n.trim().isEmpty) ? 'Player' : n.trim()))
        .toList();
    notifyListeners();
  }

  void startGame() {
    final rnd = Random();
    state.undercoverIndex = rnd.nextInt(state.players.length);
    state.pair = GameState.wordPairs[Random().nextInt(GameState.wordPairs.length)];

    for (int i = 0; i < state.players.length; i++) {
      final p = state.players[i];
      if (i == state.undercoverIndex) {
        p.role = Role.undercover;
        p.word = state.pair!.undercoverWord;
      } else {
        p.role = Role.citizen;
        p.word = state.pair!.citizensWord;
      }
      p.eliminated = false;
    }

    state.revealIndex = 0;
    state.revealVisible = false;
    state.phase = GamePhase.reveal;
    state.round = 1;
    state.votesTally.clear();
    state.whoVotedFor.clear();
    state.winner = Winner.none;
    notifyListeners();
  }

  // ----- REVEAL -----
  void toggleReveal() {
    state.revealVisible = !state.revealVisible;
    notifyListeners();
  }

  void nextReveal() {
    state.revealVisible = false;
    state.revealIndex++;
    if (state.revealIndex >= state.players.length) {
      state.phase = GamePhase.describe;
    }
    notifyListeners();
  }

  // ----- DESCRIBE -----
  void goToVoting() {
    state.phase = GamePhase.vote;
    state.votingTurnIndex = _findNextVoter(startFrom: -1);
    if (state.votingTurnIndex < 0 && state.aliveIndexes.isNotEmpty) {
      state.votingTurnIndex = state.aliveIndexes.first;
    }
    state.votesTally.clear();
    state.whoVotedFor.clear();
    notifyListeners();
  }


  int _findNextVoter({required int startFrom}) {
    final n = state.players.length;
    for (int step = 1; step <= n; step++) {
      final idx = (startFrom + step) % n;
      if (!state.players[idx].eliminated) return idx;
    }
    return -1;
  }

  // ----- VOTE -----
  void castVote(int candidateIndex) {
    final voter = state.votingTurnIndex;
    final prev = state.whoVotedFor[voter];
    if (prev != null) {
      state.votesTally[prev] = (state.votesTally[prev] ?? 0) - 1;
    }
    state.whoVotedFor[voter] = candidateIndex;
    state.votesTally[candidateIndex] = (state.votesTally[candidateIndex] ?? 0) + 1;

    final votersCount = state.aliveIndexes.length;
    final uniqueVoters =
        state.whoVotedFor.keys.where((i) => !state.players[i].eliminated).length;

    if (uniqueVoters >= votersCount) {
      _finishVoting();
    } else {
      state.votingTurnIndex = _findNextVoter(startFrom: voter);
      notifyListeners();
    }
  }

  void _finishVoting() {
    int maxVotes = -1;
    final leaders = <int>[];
    for (final entry in state.votesTally.entries) {
      if (state.players[entry.key].eliminated) continue;
      if (entry.value > maxVotes) {
        maxVotes = entry.value;
        leaders
          ..clear()
          ..add(entry.key);
      } else if (entry.value == maxVotes) {
        leaders.add(entry.key);
      }
    }

    if (leaders.isEmpty || leaders.length > 1) {
      state.eliminatedIndexThisRound = null;
    } else {
      final elim = leaders.first;
      state.players[elim].eliminated = true;
      state.eliminatedIndexThisRound = elim;
    }

    state.evaluateWin();
    state.phase = GamePhase.results;
    notifyListeners();
  }

  // ----- RESULTS / NEXT -----
  void nextRoundOrEnd() {
    if (state.isGameOver) {
      state.phase = GamePhase.gameOver;
    } else {
      state.round++;
      state.phase = GamePhase.describe;
      state.votesTally.clear();
      state.whoVotedFor.clear();
      state.eliminatedIndexThisRound = null;
    }
    notifyListeners();
  }

  void restart() {
    state.reset();
    notifyListeners();
  }

  void backToDescribe() {
    state.phase = GamePhase.describe;
    notifyListeners();
  }

}
