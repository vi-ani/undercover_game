import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../ui/background.dart';

class RevealScreen extends StatelessWidget {
  const RevealScreen({super.key, required this.controller});
  final GameController controller;

  String _avatarPathFor(int index) {
    final p = controller.state.players[index];
    final isUndercover = p.role.toString().contains('undercover');

    if (isUndercover) {
      return 'assets/images/undercover.png';
    }

    // random pics of male and female citizens
    final h = (p.name.hashCode + index * 9973).abs() % 2;
    return (h == 0)
        ? 'assets/images/citizen_w.png'
        : 'assets/images/citizen_m.png';
  }

  @override
  Widget build(BuildContext context) {
    final i = controller.state.revealIndex; // current player index
    final p = controller.state.players[i]; // the player
    final isVisible = controller.state.revealVisible; // is card visible

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

            // Role card
            Card(
              color: Colors.white.withValues(alpha: 0.10),
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
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
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
                                ?.copyWith(
                                  color: p.role!
                                          .toString()
                                          .contains('undercover')
                                      ? const Color.fromARGB(255, 255, 120, 120)
                                      : Colors.lightBlueAccent,
                                ),
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

            // Center zone, avatar
            Expanded(
              child: Center(
                child: !isVisible
                    ? SizedBox(
                        width: 180,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: controller.toggleReveal,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text('Show'),
                        ),
                      )
                    : _AvatarCircle(path: _avatarPathFor(i)),
              ),
            ),

            // Next button at the bottom
            SizedBox(
              height: 48,
              width: double.infinity,
              child: FilledButton(
                onPressed: isVisible ? controller.nextReveal : null,
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.55), // pale frame
          width: 4,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipOval(
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
