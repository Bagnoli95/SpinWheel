import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class MyFortuneWheel extends StatefulWidget {
  const MyFortuneWheel({super.key});

  @override
  State<MyFortuneWheel> createState() => _MyFortuneWheelState();
}

class _MyFortuneWheelState extends State<MyFortuneWheel>
    with SingleTickerProviderStateMixin {
  final bool _flagEncendido = true;
  late ConfettiController _controllerConfetti;

  late AnimationController _animationGirarController;
  late Animation<double> _animationGirar;
  final items = <String>[
    'Grogu',
    'Mace Windu',
    'Obi-Wan Kenobi',
    'Han Solo',
    'Luke Skywalker',
    'Darth Vader',
    'Yoda',
    'Ahsoka Tano'
  ];
  final Image imagen = Image.asset(
    'assets/wheel.png',
    fit: BoxFit.contain,
  );

  @override
  void initState() {
    super.initState();

    _controllerConfetti = ConfettiController(
      duration: const Duration(seconds: 10),
    );

    _animationGirarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animationGirar = Tween(begin: 0.0, end: 2 * pi).animate(CurvedAnimation(
      parent: _animationGirarController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controllerConfetti.dispose();
    _animationGirarController.dispose();
    super.dispose();
  }

  void _empezarAnimacion() {
    setState(() {
      print(
          'start/stop ${_animationGirarController.status} - ${_animationGirarController.isAnimating}');
      if (_animationGirarController.isAnimating) {
        _animationGirarController.stop();
      } else {
        _animationGirarController.reset();
        _animationGirarController
            .forward()
            .whenComplete(() => _empezarConfetti());
      }
    });
  }

  void _empezarConfetti() {
    setState(() {
      _controllerConfetti.play();
      print('Se ejecuto el confetti');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double myWidth = MediaQuery.of(context).size.width;
    final double myHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        //FONDO DE PANTALLA
        Container(
          color: Colors.grey,
        ),

        //FONDO DONDE VA A APARECER LAS ANIMACIONES
        Container(
          color: Colors.grey[300],
          margin: const EdgeInsets.all(50),
          height: double.infinity,
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                border: Border.all(color: Colors.grey, width: 5)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ConfettiWidget(
                  confettiController: _controllerConfetti,
                  // blastDirection: 180, // 0 es derecha,
                  blastDirectionality: BlastDirectionality.explosive,
                  particleDrag: 0.05, // apply drag to the confetti
                  emissionFrequency: 0.05, // how often it should emit
                  numberOfParticles: 50, // number of particles to emit
                  gravity: 0.05, // gravity - or fall speed
                  maxBlastForce: 60,
                  minBlastForce: 30,
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink
                  ], // manually specify the colors to be used
                  strokeWidth: 1,
                  strokeColor: Colors.white,
                ),
                AnimatedBuilder(
                    animation: _animationGirar,
                    child: Container(child: imagen),
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animationGirar.value,
                        child: child,
                      );
                    }),
              ],
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: _empezarAnimacion,
          tooltip: 'PLAY/STOP',
          child: Icon(_flagEncendido ? Icons.play_arrow : Icons.restart_alt),
        ), // This trailing comma makes auto-formatting nicer for build metho
      ],
    );
  }
}
