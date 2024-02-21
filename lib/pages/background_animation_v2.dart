import 'dart:math';

import 'package:background_animation/pages/crud_list.dart';
import 'package:background_animation/widget/spinwheel.dart';
import 'package:flutter/material.dart';
import '../widget/free_fall.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyBackGroundV2 extends StatefulWidget {
  const MyBackGroundV2({super.key});

  @override
  State<MyBackGroundV2> createState() => _MyBackGroundV2State();
}

class _MyBackGroundV2State extends State<MyBackGroundV2> with TickerProviderStateMixin {
  bool _flagEncendido = false;
  String _titulo = 'Presiona el botón para empezar';

  //ANIMACIONES Y CONTROLES PARA LA CAIDA
  late Animation animacionCaida;
  late AnimationController animacionCaidaController;
  late AnimationController animacionWiggleController;
  late AnimationController _animationGlowController;
  late Animation _animationGlow;
  late VideoPlayerController _controllerVideo;
  String variableSaludo = "Sin acceso a memoria";
  List<Map<String, dynamic>> _premios = [
    {"nombrePremio": "Sin Premios", "cantidadPremio": "1", "colorPremio": "b74093"},
    {"nombrePremio": "Sin Premios", "cantidadPremio": "1", "colorPremio": "b74093"}
  ];

  _cargarPreferencias() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      variableSaludo = pref.getString("saludo").toString();
      String? listaGuardadaString = pref.getString("memoryListaPremios");
      print("Estado conexion memoria: " + variableSaludo);
      _premios = (json.decode(listaGuardadaString!) as List).cast<Map<String, dynamic>>();
    });
  }

  //PARA SETEAR EL ESTADO INICIAL
  @override
  void initState() {
    super.initState();

    //CARGAR LISTA
    _cargarPreferencias();

    //Iniciar el controlador para la animación de Caída
    animacionCaidaController = AnimationController(vsync: this, duration: const Duration(seconds: 30));

    //Iniciar la animacion de Caída
    animacionCaida = Tween(
      begin: -0.1,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: animacionCaidaController,
      curve: const Interval(0.0, 1.0, curve: Curves.linear),
    ));

    //Iniciar el controlador para la animación de Wiggle
    animacionWiggleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
    );

    // //Animacion Glow
    // _animationGlowController = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 2),
    //   reverseDuration: const Duration(seconds: 2),
    // );

    // _animationGlowController.repeat(reverse: true);

    // _animationGlow = Tween(begin: 2.0, end: 15.0).animate(_animationGlowController)
    //   ..addListener(() {
    //     setState(() {});
    //   });

    // _animationGlow = Tween(begin: 2.0, end: 15.0).animate(_animationGlowController)
    //   ..addListener(() {
    //     setState(() {});
    //   });

    _controllerVideo = VideoPlayerController.asset("assets/Fondo2.mp4")
      ..initialize().then((_) {
        _controllerVideo.play();
        _controllerVideo.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });

    _empezarAnimacion();
  }

  //PARA ACTUALIZAR UN ESTADO
  void _empezarAnimacion() {
    setState(() {
      print('_flagEncendido : $_flagEncendido');
      if (_flagEncendido == true) {
        _titulo = 'Presiona el botón para parar';
        animacionCaidaController.repeat();
        animacionWiggleController.repeat(reverse: true);

        //CAMBIAR EL VALOR DEL FLAG
        _flagEncendido = false;
      } else {
        _titulo = 'Presiona el botón para empezar';
        animacionCaidaController.reset();
        animacionWiggleController.reset();

        //CAMBIAR EL VALOR DEL FLAG
        _flagEncendido = true;
      }
    });
  }

  @override
  void dispose() {
    animacionCaidaController.dispose();
    animacionWiggleController.dispose();
    _controllerVideo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //CALCULAR EL TAMAÑO TOTAL DE LA PANTALLA
    final double myHeight = MediaQuery.of(context).size.height;
    final double myWidth = MediaQuery.of(context).size.width;
    var ramdonCantidadEspacioParacaidas = Random().nextInt(200) + 150;

    //CALCULAMOS LA CANTIDAD DE PARACAIDAS, DEPENDIENDO DEL TAMAÑO DE LA PANTALLA
    double totalParacaidas = myWidth / ramdonCantidadEspacioParacaidas;

    // print('myHeight: $myHeight. myWidth: $myWidth');
    // print('_totalParacaidas: $totalParacaidas. ramdonCantidadEspacioParacaidas: $ramdonCantidadEspacioParacaidas');

    return Stack(
      children: [
        //FONDO DONDE VA A APARECER LAS ANIMACIONES
        Container(
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //   fit: BoxFit.cover,
            //   image: AssetImage(
            //     "assets/Background1.jpg",
            //   ),
            // ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                // Color.fromRGBO(45, 149, 150, 1),
                Color.fromRGBO(154, 208, 194, 1),
                Color.fromRGBO(45, 149, 150, 1),
                // Color.fromRGBO(154, 208, 194, 1),
              ],
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              //Fondo de video
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controllerVideo.value.size?.width ?? 0,
                    height: _controllerVideo.value.size?.height ?? 0,
                    child: VideoPlayer(_controllerVideo),
                  ),
                ),
              ),

              //Generación dinámica de los paracaidas
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     for (int k = 0; k < totalParacaidas.round(); k++)
              //       myFreeFall(
              //         animacionCaidaController: animacionCaidaController,
              //         animacionCaida: animacionCaida,
              //         animacionWiggleController: animacionWiggleController,
              //         myInicialHeight: myHeight,
              //       )
              //   ],
              // ),

              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     MyHeader(),
              //     MyFooter(),
              //   ],
              // ),

              //Contenedor de la Rueda
              Container(
                margin: EdgeInsets.all(30),
                child: MySpinWheel(premiosRueda: _premios),
                padding: EdgeInsets.all(15),
              ),
            ],
          ),
        ),

        //BOTON DE CONFIGURAR
        Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.40)),
                shadowColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyPriceScreen(
                              listaPremios: _premios,
                            )))
                  ..then((value) => _cargarPreferencias()),
              },
              iconSize: 30,
              icon: Icon(Icons.settings),
              // icon: Image.asset(
              //   "assets/ConfigBoton.png",
              //   height: 40,
              //   width: 40,
              // ),
            )),

        // //LOGO DIMO
        // Positioned(
        //   bottom: -160,
        //   right: -5,
        //   child: SizedBox(
        //     height: 500,
        //     width: 400,
        //     child: Text(variableSaludo),
        //   ),
        // ),
      ],
    );
  }
}

// List<Map<String, dynamic>> premios = [
//   {'nombrePremio': "Mochila", 'cantidadPremio': "1", 'colorPremio': Color(0xFFFF0064)},
//   {'nombrePremio': "Termo", 'cantidadPremio': "1", 'colorPremio': Color(0xFFFF7600)},
//   {'nombrePremio': "Campera", 'cantidadPremio': "1", 'colorPremio': Color(0xFFFFD500)},
//   {'nombrePremio': "500 Puntos", 'cantidadPremio': "1", 'colorPremio': Color(0xFF8CFE00)},
//   {'nombrePremio': "Agenda", 'cantidadPremio': "1", 'colorPremio': Color(0xFF00E86C)},
//   {'nombrePremio': "50 mil gs", 'cantidadPremio': "1", 'colorPremio': Color(0xFF00F4F2)},
//   {'nombrePremio': "20 Puntos", 'cantidadPremio': "1", 'colorPremio': Color(0xFF00CCFF)},
//   {'nombrePremio': "Guampa", 'cantidadPremio': "1", 'colorPremio': Color(0xFF70A2FF)},
//   {'nombrePremio': "35 Puntos", 'cantidadPremio': "1", 'colorPremio': Color(0xFFA96CFF)},
// ];
