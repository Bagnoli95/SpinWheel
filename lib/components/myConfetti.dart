import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class MyConfettiWidget extends StatelessWidget {
  const MyConfettiWidget({
    super.key,
    required ConfettiController controllerConfetti,
  }) : _controllerConfetti = controllerConfetti;

  final ConfettiController _controllerConfetti;

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _controllerConfetti,
      // blastDirection: 180, // 0 es derecha,
      blastDirectionality: BlastDirectionality.explosive,
      particleDrag: 0.05, // apply drag to the confetti
      emissionFrequency: 0.05, // how often it should emit
      numberOfParticles: 30, // number of particles to emit
      gravity: 0.05, // gravity - or fall speed
      maxBlastForce: 60,
      minBlastForce: 30,
      shouldLoop: false,
      colors: const [Colors.green, Colors.blue, Colors.pink], // manually specify the colors to be used
      strokeWidth: 1,
      strokeColor: Colors.white,
    );
  }
}
