import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../ui/background.dart';

class RevealScreen extends StatelessWidget {
  const RevealScreen({super.key, required this.controller});
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    final i = controller.state.revealIndex;
    final p = controller.state.players[i];
    final isVisible = controller.state.revealVisible;

    return AppBackground(
      imagePath: 'assets/images/bg_pattern.png', 
      repeat: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Role Reveal • Player ${i + 1}/${controller.state.players.length}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.white.withValues(alpha: 0.1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      p.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    if (!isVisible)
                      const Text(
                        'Pass the phone to the player and tap "Show". Do not let others see!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      )
                    else
                      Column(
                        children: [
                          Text(
                            p.role!.toString().contains('undercover')
                                ? 'Undercover'
                                : 'Citizen',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.amberAccent),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your word: ${p.word}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Describe this word later, but do not name it directly.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.toggleReveal,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white70),
                    ),
                    child: Text(isVisible ? 'Hide' : 'Show'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: isVisible ? controller.nextReveal : null,
                    child: const Text('Next'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
