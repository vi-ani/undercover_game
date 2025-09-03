import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../ui/background.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({super.key, required this.controller});
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    final players = controller.state.players;
    final aliveIdx = controller.state.aliveIndexes;

    // Safe voter index/name
    int voterIndex = controller.state.votingTurnIndex;
    if (voterIndex < 0 ||
        voterIndex >= players.length ||
        (voterIndex >= 0 && players[voterIndex].eliminated)) {
      voterIndex = aliveIdx.isNotEmpty ? aliveIdx.first : -1;
    }
    final voterName = (voterIndex >= 0) ? players[voterIndex].name : '—';

    return AppBackground(
      imagePath: 'assets/images/bg_pattern.png',
      repeat: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Voting — Round ${controller.state.round}',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              'Current voter: $voterName',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                itemCount: aliveIdx.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final idx = aliveIdx[i];
                  final p = players[idx];
                  final votes = controller.state.votesTally[idx] ?? 0;

                  return Card(
                    color: Colors.white.withValues(alpha: 0.10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.name,
                                    style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                                const SizedBox(height: 2),
                                Text('Votes: $votes',
                                    style: const TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          SizedBox(
                            height: 40,
                            width: 96,
                            child: FilledButton(
                              onPressed: () => controller.castVote(idx),
                              child: const Text('Vote'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Back button
            OutlinedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Description'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white70),
              ),
              onPressed: controller.backToDescribe,
            ),

            const SizedBox(height: 8),
            Text(
              'Note: in case of a tie, no one is eliminated and the game continues.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}
