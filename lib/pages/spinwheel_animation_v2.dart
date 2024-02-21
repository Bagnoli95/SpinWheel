import 'dart:io';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class MyFortuneWheel2 extends StatefulWidget {
  const MyFortuneWheel2({super.key});

  @override
  State<MyFortuneWheel2> createState() => _MyFortuneWheel2State();
}

class _MyFortuneWheel2State extends State<MyFortuneWheel2> with SingleTickerProviderStateMixin {
  final bool _flagEncendido = true;
  late ConfettiController _controllerConfetti;
  late AnimationController _animationGirarController;
  late Animation<double> _animationGirar;
  double _beginPosition = 0.0;
  double _endPosition = 1.0;

  final items = <String>['Grogu', 'Mace Windu', 'Obi-Wan Kenobi', 'Han Solo', 'Luke Skywalker', 'Darth Vader', 'Yoda', 'Ahsoka Tano'];
  final Image imagen = Image.asset(
    'assets/wheel.png',
    fit: BoxFit.fill,
  );

  @override
  void initState() {
    super.initState();

    _animationGirarController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animationGirar = Tween(begin: _beginPosition, end: _endPosition).animate(
      CurvedAnimation(
        parent: _animationGirarController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _controllerConfetti.dispose();
    _animationGirarController.dispose();
    super.dispose();
  }

  void _girarUnLugar() {
    setState(() {
      _animationGirarController.forward().whenComplete(() => {
            _beginPosition = _endPosition,
            _endPosition += 5.0,
            _animationGirarController.resync(this),
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double myHeight = MediaQuery.of(context).size.height;
    final double myWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              // Color.fromRGBO(45, 149, 150, 1),
              Color.fromRGBO(154, 208, 194, 1),
              Color.fromRGBO(45, 149, 150, 1),
              // Color.fromRGBO(154, 208, 194, 1),
            ],
          )),
        ),
        AnimatedBuilder(
            animation: _animationGirar,
            child: imagen,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animationGirar.value,
                child: child,
              );
            }),
        //INDICADOR DEL SELECCIONADO

        //Botón de Girar
        Positioned(
          child: FloatingActionButton(
            onPressed: _girarUnLugar,
            tooltip: 'Girar!',
            child: Icon(_flagEncendido ? Icons.start : Icons.pause),
          ),
        ),
      ],
    );
  }
}
