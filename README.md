# Undercover Game 🎭

A party game built with **Flutter**.

---

## 🚀 How to Run
1. Install [Flutter](https://flutter.dev/docs/get-started/install) (3.35+ recommended).  
2. Clone this repository.  
3. Fetch dependencies:
   flutter pub get
4. Run on an emulator or connected device:
    flutter run

For the development, I have used emulator Pixel 7, Android 13.0.

## 📂 App Structure
lib/
├── controllers/
│ └── game_controller.dart # Main game logic and state transitions
│
├── models/
│ ├── enums.dart # Game enums (roles, phases, winner)
│ ├── game_state.dart # Game state: players, roles, words, phases
│ ├── player.dart # Player model
│ └── word_pair.dart # Word pair model
│
├── screens/
│ ├── describe_screen.dart
│ ├── game_over_screen.dart
│ ├── results_screen.dart
│ ├── reveal_screen.dart
│ ├── setup_screen.dart
│ └── vote_screen.dart
│
├── ui/
│ ├── background.dart # Background widget with overlay
│ └── theme.dart # Global theme configuration
│
└── main.dart # App entry point
