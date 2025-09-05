import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/enums.dart';
import '../ui/background.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key, required this.controller});
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    String winnerText;
    switch (controller.state.winner) {
      case Winner.citizens:
        winnerText = 'Citizens Win!';
        break;
      case Winner.undercover:
        winnerText = 'Undercover Wins!';
        break;
      case Winner.none:
        winnerText = 'Game Over';
        break;
    }

    final undercoverName = (controller.state.undercoverIndex == null)
        ? '—'
        : controller.state.players[controller.state.undercoverIndex!].name;

    return AppBackground(
      imagePath: 'assets/images/bg_pattern.png',
      repeat: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Game Over',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      winnerText,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Undercover was: $undercoverName',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    if (controller.state.pair != null)
                      Text(
                        'Word pair:\nCitizens — "${controller.state.pair!.citizensWord}"\n'
                        'Undercover — "${controller.state.pair!.undercoverWord}"',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white70),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- list of players ---
            Expanded(
              child: ListView(
                children: [
                  for (var p in controller.state.players)
                    Card(
                      color: Colors.white.withValues(alpha: 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          p.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${p.role == Winner.undercover ? "Undercover" : "Citizen"} • Word: ${p.word}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        leading: Icon(
                          p.role.toString().contains('undercover')
                              ? Icons.visibility_off
                              : Icons.people,
                          color: p.role.toString().contains('undercover')
                              ? Colors.amberAccent
                              : Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            
            // --- buttons ---
            FilledButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Play Again'),
              onPressed: () {
                controller.startGame();
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('Back to Setup'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white70),
              ),
              onPressed: controller.restart,
            ),
          ],
        ),
      ),
    );
  }
}
