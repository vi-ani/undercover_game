import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../ui/background.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.controller});
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    final elim = controller.state.eliminatedIndexThisRound;
    final text = (elim == null)
        ? 'It\'s a tie! No one is eliminated.'
        : 'Eliminated: ${controller.state.players[elim].name}';

    return AppBackground(
      imagePath: 'assets/images/bg_pattern.png',
      repeat: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Round ${controller.state.round} Results',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: controller.nextRoundOrEnd,
              child: Text(
                controller.state.isGameOver
                    ? 'Show Winner'
                    : 'Next Phase',
              ),
            )
          ],
        ),
      ),
    );
  }
}
