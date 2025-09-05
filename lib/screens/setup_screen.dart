import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/game_state.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key, required this.controller});
  final GameController controller;

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

// Stateful widget to manage player count and names
class _SetupScreenState extends State<SetupScreen> {
  int playersCount = 3;
  final List<TextEditingController> _controllers = [];

// Initialize text controllers
  @override
  void initState() {
    super.initState();
    _rebuildControllers();
  }

// Rebuild text controllers when playersCount changes
  void _rebuildControllers() {
    _controllers
      ..clear()
      ..addAll(List.generate(playersCount,
          (i) => TextEditingController(text: '')));
  }
// Dispose controllers to avoid memory leaks
  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

// Takes limits from GameState
  @override
  Widget build(BuildContext context) {
    const minP = GameState.minPlayers;
    const maxP = GameState.maxPlayers;

    return Stack(
      children: [
        // --- BACKGROUND IMAGE ---
        Positioned.fill(
          child: Image.asset(
            'assets/images/spy_bg.png',
            fit: BoxFit.cover, // cover the entire screen
            alignment: Alignment.center,
          ),
        ),

        // --- DARK OVERLAY (to improve text readability) ---
        Positioned.fill(
          child: Container(color: Colors.black.withValues(alpha: 0.35)),
        ),

        // --- MAIN CONTENT ---
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  'Player Setup',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),

                // Players count control panel – semi-transparent background
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      const Text('Players:',
                          style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 12),
                      IconButton(
                        onPressed: playersCount > minP
                            ? () => setState(() {
                                  playersCount--;
                                  _rebuildControllers();
                                })
                            : null,
                        icon: const Icon(Icons.remove, color: Colors.white),
                      ),
                      Text('$playersCount',
                          style: const TextStyle(color: Colors.white)),
                      IconButton(
                        onPressed: playersCount < maxP
                            ? () => setState(() {
                                  playersCount++;
                                  _rebuildControllers();
                                })
                            : null,
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Text('($minP–$maxP)',
                          style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Text fields for player names
                ...List.generate(playersCount, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: TextField(
                      controller: _controllers[i],
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Player's name",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  );
                }),


                const SizedBox(height: 16),

                // "Start Game" button
                SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Game'),
                    onPressed: () {
                      final names = <String>[];
                      for (int i = 0; i < _controllers.length; i++) {
                        final t = _controllers[i].text.trim();
                        names.add(t.isEmpty ? 'Player ${i + 1}' : t);
                      }
                      widget.controller.createPlayers(names);
                      widget.controller.startGame();
                    },

                    // Slight transparency to blend with background
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 72, 96, 231).withValues(alpha: 0.9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
