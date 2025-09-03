import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:undercover_game/main.dart';

void main() {
  testWidgets('Smoke test: app loads and shows SetupScreen',
      (WidgetTester tester) async {
    // Load the app
    await tester.pumpWidget(const UndercoverApp());

    // Verify that the SetupScreen is shown
    expect(find.text('Player Setup'), findsOneWidget);

    // Verify that the "Start Game" button is present
    expect(find.text('Start Game'), findsOneWidget);
  });
}
