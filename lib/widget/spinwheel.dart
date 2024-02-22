import 'dart:async';
import 'dart:convert';

import 'package:background_animation/components/filtro.dart';
import 'package:background_animation/components/myConfetti.dart';
import 'package:background_animation/components/ticket.dart';
import 'package:background_animation/pages/winner_animation.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySpinWheel extends StatefulWidget {
  MySpinWheel({super.key, required this.premiosRueda});

  List<Map<String, dynamic>> premiosRueda;

  @override
  State<MySpinWheel> createState() => _MySpinWheelState();
}

class _MySpinWheelState extends State<MySpinWheel> with TickerProviderStateMixin {
  StreamController<int> selected = StreamController<int>();
  late ConfettiController _controllerConfetti;
  late AnimationController _controllerFiltro;
  late AnimationController _controllerTicket;
  late Animation _animacionFiltro;
  late Animation _animacionTicket;
  bool _flagBotones = false;
  int indexPremio = 0;
  late List<Map<String, dynamic>> premiosLimpio;

  List<Map<String, dynamic>> _premios = [
    {"nombrePremio": "Sin Premios", "cantidadPremio": "100", "colorPremio": "b74093"},
    {"nombrePremio": "Sin Premios", "cantidadPremio": "100", "colorPremio": "b74093"}
  ];

  _guardarPreferencias(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("INDEX: " + index.toString());
    setState(() {
      var cantAux = int.parse(widget.premiosRueda[index]["cantidadPremio"]);
      String cantAux2 = (cantAux - 1).toString();

      widget.premiosRueda[index]["cantidadPremio"] = cantAux2;
      pref.remove("memoryListaPremios");
      pref.setString("memoryListaPremios", jsonEncode(widget.premiosRueda));
    });
    _limpiarLista(index);
  }

  _limpiarLista(int indexDelete) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      print("nombrePremios: " + widget.premiosRueda[indexDelete]["nombrePremio"]);
      print("cantidadPremios: " + widget.premiosRueda[indexDelete]["cantidadPremio"]);
      if (widget.premiosRueda[indexDelete]["cantidadPremio"] == "0") {
        widget.premiosRueda.removeAt(indexDelete);
        pref.remove("memoryListaPremios");
        pref.setString("memoryListaPremios", jsonEncode(widget.premiosRueda));
        print("Se cumplio el if");
      } else {
        print("No se cumplio el if");
      }
    });
  }

  @override
  void initState() {
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

    //Iniciar la animación del filtro
    _animacionFiltro = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controllerFiltro, curve: Curves.linear),
    );

    //Iniciar la animación del ticket
    _animacionTicket = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controllerTicket, curve: Curves.elasticOut),
    );
    super.initState();
  }

  void girarRuleta() {
    _controllerConfetti.stop();
    int winner = Fortune.randomInt(0, widget.premiosRueda.length);
    setState(() {
      selected.add(winner);
      _flagBotones = true;
      indexPremio = winner;
    });
    print("GANADOR: " + widget.premiosRueda[winner]["nombrePremio"] + ". Index: " + winner.toString());
  }

  void cerrarTicket(int winnerIndex) {
    setState(() {
      _guardarPreferencias(winnerIndex);
      _flagBotones = false;
      _controllerFiltro.reset();
      _controllerConfetti.stop();
      _controllerTicket.reset();
    });
  }

  void tirarConfetti() {
    setState(() {
      _controllerConfetti.play();
      _controllerFiltro.forward().whenComplete(() => _controllerTicket.forward());
    });
  }

  @override
  void dispose() {
    selected.close();
    _controllerConfetti.dispose();
    _controllerFiltro.dispose();
    _controllerTicket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool flagColor = true;
    return Stack(
      children: [
        //RUEDA
        Column(
          children: [
            Container(
              height: 400,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange.shade300, boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade100,
                    blurRadius: 5,
                    spreadRadius: 4,
                  ),
                ]),
                // decoration: BoxDecoration(
                //   shape: BoxShape.circle,
                //   color: Colors.yellow.shade300,
                // ),
                child: FortuneWheel(
                  alignment: Alignment.centerRight,
                  animateFirst: false,
                  indicators: const <FortuneIndicator>[
                    FortuneIndicator(
                        alignment: Alignment.centerRight, // <-- changing the position of the indicator
                        child: TriangleIndicator(
                          color: Colors.yellow,
                        ))
                  ],
                  // physics: CircularPanPhysics(duration: Duration(seconds: 1), curve: Curves.decelerate),
                  selected: selected.stream,
                  items: [
                    for (var premio in widget.premiosRueda)
                      FortuneItem(
                        child: Text(
                          premio["nombrePremio"].toUpperCase(),
                          style: const TextStyle(fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        style: FortuneItemStyle(color: HexColor(premio["colorPremio"]), borderColor: Colors.white, borderWidth: 4),
                      )
                  ],

                  onAnimationEnd: () {
                    tirarConfetti();
                  },
                ),
              ),
            ),
          ],
        ),

        // FONDO GRIS TRANSPARENTE
        MyFiltro(animacionFiltro: _animacionFiltro),

        // //CONFETTI
        // Center(
        //   child: MyConfettiWidget(controllerConfetti: _controllerConfetti),
        // ),

        //TICKET DE PREMIO
        MyTicketWinner(animacionTicket: _animacionTicket, tituloPremio: widget.premiosRueda[indexPremio]["nombrePremio"], premio: ''),

        //Botón de VOLVER / GIRAR
        _flagBotones == true
            ? Positioned(
                bottom: -38,
                right: 0,
                left: 0,
                child: IconButton(
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.40)),
                  //   shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                  // ),
                  onPressed: () => {cerrarTicket(indexPremio)},
                  iconSize: 10,
                  // icon: Image.asset("assets/TABLERO-02.png", height: 200, width: 300),
                  icon: Image.asset("assets/button2.png", height: 200, width: 300),
                ),
              )
            : Positioned(
                bottom: -38,
                right: 0,
                left: 0,
                child: IconButton(
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.40)),
                  //   shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                  // ),
                  onPressed: () => {girarRuleta()},
                  iconSize: 10,
                  // icon: Image.asset("assets/TABLERO-02.png", height: 200, width: 300),
                  icon: Image.asset("assets/button2.png", height: 200, width: 300),
                ),
              ),
      ],
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
