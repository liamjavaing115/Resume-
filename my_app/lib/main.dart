import 'package:flutter/material.dart';
import 'gradient_container.dart';

// Entry point of the Flutter app
void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false, // removes the debug banner
      home: Scaffold(
        // Scaffold gives structure to the app (background, body, etc.)
        body: GradientContainer( // // our custom background + content
          Color.fromARGB(255, 33, 5, 109), // gradient color 1
          Color.fromARGB(255, 68, 21, 149), // gradient color 2
        ),
      ),
    ),
  );
}

/*

runApp mounts the widget tree.

MaterialApp provides Material UI, routing, themes.

Scaffold gives a page layout (safe area, body, FAB slots, etc.).

We render our own widget (GradientContainer) as the page body.


Boot: main() runs runApp(MaterialApp(...)).

First frame: MaterialApp → Scaffold → GradientContainer → DiceRoller.

Render: DiceRoller.build reads _currentDiceRoll (initially 2) and shows assets/images/dice-2.png.

Interaction: User taps “Roll Dice” → _rollDice() executes.

State change: _randomizer.nextInt(6) + 1 picks 1–6, stored in _currentDiceRoll, wrapped in setState.

Rebuild: Flutter re-calls build for _DiceRollerState; the Image.asset path changes to the new face; the UI updates.
 */