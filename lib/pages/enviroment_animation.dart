import 'package:flutter/material.dart';

import '../components/header_footer.dart';

class MyEnviroment extends StatefulWidget {
  const MyEnviroment({super.key});

  @override
  State<MyEnviroment> createState() => _MyEnviromentState();
}

class _MyEnviromentState extends State<MyEnviroment> {
  bool _flagEncendido = true;
  String _titulo = 'Presiona el botón para empezar';
//PARA ACTUALIZAR UN ESTADO
  void _empezarAnimacion() {
    setState(() {
      print('_flagEncendido : $_flagEncendido');
      if (_flagEncendido == true) {
        _titulo = 'Presiona el botón para parar';

        //CAMBIAR EL VALOR DEL FLAG
        _flagEncendido = false;
      } else {
        _titulo = 'Presiona el botón para empezar';

        //CAMBIAR EL VALOR DEL FLAG
        _flagEncendido = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_titulo),
      ),
      body: Stack(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //HEADER
                  const MyHeader(),
                  //BODY
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 1,
                          blurRadius: 15,
                          blurStyle: BlurStyle.solid,
                        )
                      ],
                    ),
                  ),
                  const MyFooter(),
                ],
              )),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _empezarAnimacion,
        tooltip: 'PLAY/STOP',
        child: Icon(_flagEncendido ? Icons.play_arrow : Icons.restart_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
