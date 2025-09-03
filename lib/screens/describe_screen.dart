import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../ui/background.dart';

class DescribeScreen extends StatelessWidget {
  const DescribeScreen({super.key, required this.controller});
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    final alive = controller.state.aliveIndexes
        .map((i) => controller.state.players[i].name)
        .join(' • ');

    return AppBackground(
      imagePath: 'assets/images/bg_pattern.png',
      repeat: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Description phase — Round ${controller.state.round}',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              'Alive players: $alive',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Now each player gives a short description of their word (without saying it directly). '
                  'After everyone finishes - proceed to voting.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              icon: const Icon(Icons.how_to_vote),
              label: const Text('Proceed to Voting'),
              onPressed: controller.goToVoting,
            )
          ],
        ),
      ),
    );
  }
}
