import 'dart:math';

import 'package:flutter/material.dart';
import '../components/parachute.dart';

class myFreeFall extends StatelessWidget {
  const myFreeFall({
    super.key,
    required this.animacionCaidaController,
    required this.animacionCaida,
    required this.animacionWiggleController,
    required this.myInicialHeight,
  });

  final AnimationController animacionCaidaController;
  final Animation animacionCaida;
  final AnimationController animacionWiggleController;
  final double myInicialHeight;

  @override
  Widget build(BuildContext context) {
    //GENERACION DE VARIABLES RAMDOMICAS PARA QUE TENGA UN ASPECTO MAS NATURAL
    var radomDouble = Random().nextDouble() + 1;
    var ramdonInt = Random().nextInt(2) + 1;
    var ramdonMyVariableHeight = Random().nextDouble() + radomDouble * ramdonInt;
    var ramdonParachuteDirection = Random().nextBool();
    var ramdonDurationSecons = Random().nextInt(70) + 30;
    var ramdonParachuteSize = Random().nextInt(80) + 50;
    animacionCaidaController.duration = Duration(seconds: ramdonDurationSecons);
    // print('ramdonMyVariableHeight: $ramdonMyVariableHeight. ramdonParachuteDirection: $ramdonParachuteDirection. ramdonDurationSecons: $ramdonDurationSecons. ramdonParachuteSize: $ramdonParachuteSize.');

    return AnimatedBuilder(
      animation: animacionCaidaController,
      builder: (BuildContext context, child) => Transform(
        transform: Matrix4.translationValues(0.0, animacionCaida.value * myInicialHeight * ramdonMyVariableHeight, 0.0),
        child: AnimatedBuilder(
          animation: animacionCaidaController,
          builder: (BuildContext context, child) => Transform.rotate(
            angle: ramdonParachuteDirection ? (animacionWiggleController.value / 1.4) * -1 : animacionWiggleController.value / 1.4,
            child: MyParachutes(MyHeight: ramdonParachuteSize.toDouble(), MyWidth: ramdonParachuteSize.toDouble(), MyDirection: ramdonParachuteDirection),
          ),
        ),
      ),
    );
  }
}
