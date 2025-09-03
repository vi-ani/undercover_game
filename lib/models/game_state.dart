import 'player.dart';
import 'word_pair.dart';
import 'enums.dart';

class GameState {
  // Configuration
  static const int minPlayers = 3;
  static const int maxPlayers = 12;

  // Word pools
  static const List<WordPair> wordPairs = [
    WordPair('Cat', 'Tiger'),
    WordPair('Coffee', 'Tea'),
    WordPair('Ship', 'Boat'),
    WordPair('Apple', 'Pear'),
    WordPair('Moon', 'Sun'),
    WordPair('Keyboard', 'Piano'),
    WordPair('Chair', 'Stool'),
  ];

  // Game data
  List<Player> players = [];
  int? undercoverIndex;
  WordPair? pair;
  int round = 1;

  // Current phase
  GamePhase phase = GamePhase.setup;

  // Role reveal state
  int revealIndex = 0;
  bool revealVisible = false;

  // Voting state
  int votingTurnIndex = 0;
  final Map<int, int> votesTally = {};    // candidateIndex -> votes count
  final Map<int, int> whoVotedFor = {};   // voterIndex -> candidateIndex

  // Round results / winner
  int? eliminatedIndexThisRound;
  Winner winner = Winner.none;

  void reset() {
    players.clear();
    undercoverIndex = null;
    pair = null;
    round = 1;
    phase = GamePhase.setup;
    revealIndex = 0;
    revealVisible = false;
    votingTurnIndex = 0;
    votesTally.clear();
    whoVotedFor.clear();
    eliminatedIndexThisRound = null;
    winner = Winner.none;
  }

  bool get isGameOver => winner != Winner.none;

  // Get indexes of alive players
  List<int> get aliveIndexes => [
        for (int i = 0; i < players.length; i++)
          if (!players[i].eliminated) i
      ];

  // Evaluate win conditions
  void evaluateWin() {
    if (undercoverIndex == null) return;
    final underAlive = !players[undercoverIndex!].eliminated;
    final alive = aliveIndexes;
    if (!underAlive) {
      winner = Winner.citizens;
    } else if (alive.length == 2) {
      winner = Winner.undercover;
    } else {
      winner = Winner.none;
    }
  }
}
