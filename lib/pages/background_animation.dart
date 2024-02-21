// import 'package:flutter/material.dart';
// import '../components/parachute.dart';

// class MyBackGround extends StatefulWidget {
//   MyBackGround({super.key});

//   @override
//   State<MyBackGround> createState() => _MyBackGroundState();
// }

// class _MyBackGroundState extends State<MyBackGround> with TickerProviderStateMixin {
//   bool _flagEncendido = true;
//   String _titulo = 'Presiona el botón para empezar';

//   late Animation animacionCaida;
//   late AnimationController animacionCaidaController;

//   late Animation animacionSegundaCaida;
//   late AnimationController animacionCaidaSegundaController;

//   late Animation animacionWiggle;
//   late AnimationController animacionWiggleController;

//   //PARA SETEAR EL ESTADO INICIAL
//   @override
//   void initState() {
//     super.initState();
//     //Iniciar el controlador para la animación de Caída
//     animacionCaidaController = AnimationController(vsync: this, duration: Duration(seconds: 30));
//     animacionCaidaSegundaController = AnimationController(vsync: this, duration: Duration(seconds: 30));

//     //Iniciar la animacion de Caída
//     animacionCaida = Tween(
//       begin: -0.1,
//       end: 0.8,
//     ).animate(CurvedAnimation(
//       parent: animacionCaidaController,
//       curve: Interval(0.0, 0.6666666666666667, curve: Curves.linear),
//     ));

//     //Iniciar la animacion de Caída
//     animacionSegundaCaida = Tween(
//       begin: -0.1,
//       end: 0.8,
//     ).animate(CurvedAnimation(
//       parent: animacionCaidaSegundaController,
//       curve: Interval(0.3333333333333333, 1.0, curve: Curves.linear),
//     ));

//     //Iniciar el controlador para la animación de Wiggle
//     animacionWiggleController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//       reverseDuration: Duration(seconds: 2),
//     );
//   }

//   //PARA ACTUALIZAR UN ESTADO
//   void _empezarAnimacion() {
//     setState(() {
//       print('_flagEncendido : ' + _flagEncendido.toString());
//       if (_flagEncendido == true) {
//         _titulo = 'Presiona el botón para parar';
//         animacionCaidaController.repeat();
//         animacionCaidaSegundaController.repeat();
//         animacionWiggleController.repeat(reverse: true);

//         //CAMBIAR EL VALOR DEL FLAG
//         _flagEncendido = false;
//       } else {
//         _titulo = 'Presiona el botón para empezar';

//         animacionCaidaController.reset();
//         animacionCaidaSegundaController.reset();
//         animacionWiggleController.reset();
//         //CAMBIAR EL VALOR DEL FLAG
//         _flagEncendido = true;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     //Variables locales
//     final double myWidth = MediaQuery.of(context).size.width;
//     final double myHeight = MediaQuery.of(context).size.height;
//     print('myHeight: ' + myHeight.toString() + '. myWidth: ' + myWidth.toString());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(_titulo),
//       ),
//       body: Stack(
//         children: [
//           //FONDO DE PANTALLA
//           Container(
//             color: Colors.grey,
//           ),
//           //FONDO DONDE VA A APARECER LAS ANIMACIONES
//           Container(
//             color: Colors.grey[300],
//             margin: EdgeInsets.all(50),
//             height: double.infinity,
//             width: double.infinity,
//             child: Stack(
//               children: [
//                 //PRIMERA OLA
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     AnimatedBuilder(
//                       animation: animacionCaidaController,
//                       builder: (BuildContext context, child) => Transform(
//                         transform: Matrix4.translationValues(0.0, animacionCaida.value * myHeight * 1.2, 0.0),
//                         child: AnimatedBuilder(
//                           animation: animacionCaidaController,
//                           builder: (BuildContext context, child) => Transform.rotate(
//                             angle: animacionWiggleController.value / 1.4,
//                             child: MyParachutes(MyHeight: 50, MyWidth: 50),
//                           ),
//                         ),
//                       ),
//                     ),
//                     AnimatedBuilder(
//                       animation: animacionCaidaController,
//                       builder: (BuildContext context, child) => Transform(
//                         transform: Matrix4.translationValues(0.0, animacionCaida.value * myHeight * 1.2, 0.0),
//                         child: AnimatedBuilder(
//                           animation: animacionCaidaController,
//                           builder: (BuildContext context, child) => Transform.rotate(
//                             angle: animacionWiggleController.value / 1.4,
//                             child: MyParachutes(MyHeight: 50, MyWidth: 50),
//                           ),
//                         ),
//                       ),
//                     ),
//                     AnimatedBuilder(
//                       animation: animacionCaidaController,
//                       builder: (BuildContext context, child) => Transform(
//                         transform: Matrix4.translationValues(0.0, animacionCaida.value * myHeight * 1.4, 0.0),
//                         child: AnimatedBuilder(
//                           animation: animacionCaidaController,
//                           builder: (BuildContext context, child) => Transform.rotate(
//                             angle: animacionWiggleController.value / 1.4,
//                             child: MyParachutes(MyHeight: 80, MyWidth: 80),
//                           ),
//                         ),
//                       ),
//                     ),
//                     AnimatedBuilder(
//                       animation: animacionCaidaController,
//                       builder: (BuildContext context, child) => Transform(
//                         transform: Matrix4.translationValues(0.0, animacionCaida.value * myHeight * 1.7, 0.0),
//                         child: AnimatedBuilder(
//                           animation: animacionCaidaController,
//                           builder: (BuildContext context, child) => Transform.rotate(
//                             angle: animacionWiggleController.value / 1.4,
//                             child: MyParachutes(MyHeight: 70, MyWidth: 70),
//                           ),
//                         ),
//                       ),
//                     ),
//                     //DEFINITIVO!
//                     AnimatedBuilder(
//                       animation: animacionCaidaController,
//                       builder: (BuildContext context, child) => Transform(
//                         transform: Matrix4.translationValues(0.0, animacionCaida.value * myHeight, 0.0),
//                         child: AnimatedBuilder(
//                           animation: animacionCaidaController,
//                           builder: (BuildContext context, child) => Transform.rotate(
//                             angle: animacionWiggleController.value / 1.4,
//                             child: MyParachutes(MyHeight: 60, MyWidth: 60),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 //SEGUNDA HOLA
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     AnimatedBuilder(
//                       animation: animacionCaidaSegundaController,
//                       builder: (BuildContext context, child) => Transform(
//                         transform: Matrix4.translationValues(0.0, animacionSegundaCaida.value * myHeight * 1.2, 0.0),
//                         child: AnimatedBuilder(
//                           animation: animacionCaidaSegundaController,
//                           builder: (BuildContext context, child) => Transform.rotate(
//                             angle: animacionWiggleController.value / 1.4,
//                             child: MyParachutes(MyHeight: 50, MyWidth: 50),
//                           ),
//                         ),
//                       ),
//                     ),
//                     AnimatedBuilder(
//                       animation: animacionCaidaSegundaController,
//                       builder: (BuildContext context, child) => Transform(
//                         transform: Matrix4.translationValues(0.0, animacionSegundaCaida.value * myHeight * 1.4, 0.0),
//                         child: AnimatedBuilder(
//                           animation: animacionCaidaSegundaController,
//                           builder: (BuildContext context, child) => Transform.rotate(
//                             angle: animacionWiggleController.value / 1.4,
//                             child: MyParachutes(MyHeight: 80, MyWidth: 80),
//                           ),
//                         ),
//                       ),
//                     ),
//                     AnimatedBuilder(
//                       animation: animacionCaidaSegundaController,
//                       builder: (BuildContext context, child) => Transform(
//                         transform: Matrix4.translationValues(0.0, animacionSegundaCaida.value * myHeight * 1.7, 0.0),
//                         child: AnimatedBuilder(
//                           animation: animacionCaidaSegundaController,
//                           builder: (BuildContext context, child) => Transform.rotate(
//                             angle: animacionWiggleController.value / 1.4,
//                             child: MyParachutes(MyHeight: 70, MyWidth: 70),
//                           ),
//                         ),
//                       ),
//                     ),
//                     //DEFINITIVO!
//                     AnimatedBuilder(
//                       animation: animacionCaidaSegundaController,
//                       builder: (BuildContext context, child) => Transform(
//                         transform: Matrix4.translationValues(0.0, animacionSegundaCaida.value * myHeight, 0.0),
//                         child: AnimatedBuilder(
//                           animation: animacionCaidaSegundaController,
//                           builder: (BuildContext context, child) => Transform.rotate(
//                             angle: animacionWiggleController.value / 1.4,
//                             child: MyParachutes(MyHeight: 60, MyWidth: 60),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _empezarAnimacion,
//         tooltip: 'PLAY/STOP',
//         child: Icon(_flagEncendido ? Icons.play_arrow : Icons.restart_alt),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
