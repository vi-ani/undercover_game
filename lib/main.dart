import 'package:flutter/material.dart';
import 'controllers/game_controller.dart';
import 'models/enums.dart';
import 'screens/setup_screen.dart';
import 'screens/reveal_screen.dart';
import 'screens/describe_screen.dart';
import 'screens/vote_screen.dart';
import 'screens/results_screen.dart';
import 'screens/game_over_screen.dart';
import 'ui/theme.dart';

void main() {
  runApp(const UndercoverApp());
}

class UndercoverApp extends StatelessWidget {
  const UndercoverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Undercover Game',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const GameRoot(),
    );
  }
}

class GameRoot extends StatefulWidget {
  const GameRoot({super.key});

  @override
  State<GameRoot> createState() => _GameRootState();
}

class _GameRootState extends State<GameRoot> {
  late final GameController controller;

  @override
  void initState() {
    super.initState();
    controller = GameController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final phase = controller.state.phase;
        Widget body;
        switch (phase) {
          case GamePhase.setup:
            body = SetupScreen(controller: controller);
            break;
          case GamePhase.reveal:
            body = RevealScreen(controller: controller);
            break;
          case GamePhase.describe:
            body = DescribeScreen(controller: controller);
            break;
          case GamePhase.vote:
            body = VoteScreen(controller: controller);
            break;
          case GamePhase.results:
            body = ResultsScreen(controller: controller);
            break;
          case GamePhase.gameOver:
            body = GameOverScreen(controller: controller);
            break;
        }

        return Scaffold(
          extendBodyBehindAppBar: true, // фон будет подниматься под AppBar
          appBar: AppBar(
            backgroundColor: Colors.transparent, // прозрачный фон
            elevation: 0, // без тени
            title: const Text(
              'Undercover Game',
              style: TextStyle(color: Colors.black), // текст чёрный
            ),
            centerTitle: true,
          ),
          body: SafeArea(child: body),
        );

      },
    );
  }
}
