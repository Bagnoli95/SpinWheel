import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

import '../components/myConfetti.dart';
import '../components/filtro.dart';
import '../components/ticket.dart';

class MyWinnerCard extends StatefulWidget {
  const MyWinnerCard({super.key});

  @override
  State<MyWinnerCard> createState() => _MyWinnerCardState();
}

class _MyWinnerCardState extends State<MyWinnerCard> with TickerProviderStateMixin {
  bool _flagEncendido = false;
  String _titulo = 'Presiona el botón para empezar';
  final String _premio = 'TE GANASTE UN PREMIO';
  final String _tituloPremio = 'FELICITACIONES';

  late ConfettiController _controllerConfetti;
  late AnimationController _controllerFiltro;
  late AnimationController _controllerTicket;
  late Animation _animacionFiltro;
  late Animation _animacionTicket;

  @override
  void initState() {
    super.initState();

    _controllerConfetti = ConfettiController(
      duration: const Duration(seconds: 10),
    );

    _controllerFiltro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _controllerTicket = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animacionFiltro = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controllerFiltro, curve: Curves.linear),
    );

    _animacionTicket = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controllerTicket, curve: Curves.elasticOut),
    );
    _empezarAnimacion();
  }

  @override
  void dispose() {
    _controllerConfetti.dispose();
    _controllerFiltro.dispose();
    _controllerTicket.dispose();
    super.dispose();
  }

  //PARA ACTUALIZAR UN ESTADO
  void _empezarAnimacion() {
    setState(() {
      print('_flagEncendido : $_flagEncendido');
      if (_flagEncendido == true) {
        _titulo = 'Presiona el botón para parar';

        _controllerFiltro.forward().whenComplete(() => _controllerTicket.forward());
        // _controllerConfetti.play();

        //CAMBIAR EL VALOR DEL FLAG
        _flagEncendido = false;
      } else {
        _titulo = 'Presiona el botón para empezar';
        _controllerFiltro.reset();
        // _controllerConfetti.stop();
        _controllerTicket.reset();

        //CAMBIAR EL VALOR DEL FLAG
        _flagEncendido = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          // decoration: _flagEncendido ? BoxDecoration(color: Colors.green) : BoxDecoration(color: Colors.amber),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // FONDO GRIS TRANSPARENTE
              MyFiltro(animacionFiltro: _animacionFiltro),

              //CONFETIS
              MyConfettiWidget(controllerConfetti: _controllerConfetti),

              //TICKET DE PREMIO
              MyTicketWinner(animacionTicket: _animacionTicket, tituloPremio: _tituloPremio, premio: _premio),
            ],
          ),
        ),
      ],
    );
  }
}
