import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/game_state.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key, required this.controller});
  final GameController controller;

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int playersCount = 3;
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _rebuildControllers();
  }

  void _rebuildControllers() {
    _controllers
      ..clear()
      ..addAll(List.generate(playersCount,
          (i) => TextEditingController(text: '')));
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  const minP = GameState.minPlayers;
  const maxP = GameState.maxPlayers;

  return Stack(
    children: [
      // --- ФОН ---
      Positioned.fill(
        child: Image.asset(
          'assets/images/spy_bg.png',
          fit: BoxFit.cover, // картинка на весь экран
          alignment: Alignment.center,
        ),
      ),

      // --- ЛЁГКОЕ ЗАТЕМНЕНИЕ (чтобы текст лучше читался) ---
      Positioned.fill(
        child: Container(color: Colors.black.withOpacity(0.35)),
      ),

      // --- КОНТЕНТ ---
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Text(
                'Настройка игроков',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 12),

              // Панель количества игроков – делаем её полупрозрачной
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    const Text('Количество:', style: TextStyle(color: Colors.white)),
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
                    Text('$playersCount', style: const TextStyle(color: Colors.white)),
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
                    const Text('($minP–$maxP)', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Поля ввода имён игроков
              ...List.generate(playersCount, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: TextField(
                    controller: _controllers[i],
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      // labelText убрали
                      hintText: 'Player\'s name',
                    ),
                  ),
                );
              }),

              const SizedBox(height: 16),

              // Кнопка "Начать игру"
              SizedBox(
                height: 48,
                child: FilledButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Начать игру'),
                  onPressed: () {
                    final names = <String>[];
                    for (int i = 0; i < _controllers.length; i++) {
                      final t = _controllers[i].text.trim();
                      names.add(t.isEmpty ? 'Player ${i + 1}' : t);
                    }
                    widget.controller.createPlayers(names);
                    widget.controller.startGame();
                  },

                  // немного прозрачности, чтобы гармонировать с фоном
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.indigoAccent.withOpacity(0.9),
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