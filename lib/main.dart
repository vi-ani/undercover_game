import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Undercover',
              style: GoogleFonts.barrio(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          body: body,
        );
      },
    );
  }
}
