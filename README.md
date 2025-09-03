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


## 🕹️ Game Flow

1. **Setup Screen**  
   Players choose the number of participants (3–12) and enter their names.  

2. **Role Reveal**  
   Each player secretly checks their role and word.  
   - Citizens receive similar words.  
   - The Undercover gets a different word.  
   - Citizen avatars (male/female) are assigned randomly, the Undercover has a unique avatar.  

3. **Word Description**  
   One by one, players give short descriptions of their word without naming it directly.  

4. **Voting**  
   All players vote to eliminate the one they suspect is the Undercover.  

5. **Results & Game Over**  
   - After voting, players see who was eliminated.  
   - The game continues until the Undercover is found or only two players remain.  
   - At the end, the winner is revealed along with all roles and assigned words.  
