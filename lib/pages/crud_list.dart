import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPriceScreen extends StatefulWidget {
  MyPriceScreen({super.key, required this.listaPremios});

  List<Map<String, dynamic>> listaPremios;

  @override
  State<MyPriceScreen> createState() => _MyPriceScreenState();
}

class _MyPriceScreenState extends State<MyPriceScreen> {
  //Guarda la lista en memoria
  _guardarPreferencias(List<Map<String, dynamic>> listaTemporal) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.remove("memoryListaPremios");
      pref.remove("saludo");
      pref.setString("memoryListaPremios", jsonEncode(listaTemporal));
      widget.listaPremios = listaTemporal;
      pref.setString("saludo", "Leyendo datos desde la memoria");
    });
  }

  _defaultPreferencias() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      List<Map<String, String>> listaTemporal = [
        {'nombrePremio': "Portatarjeta", 'cantidadPremio': "20", 'colorPremio': "7FB3D5"},
        {'nombrePremio': "Agendas", 'cantidadPremio': "25", 'colorPremio': "85C1E9"},
        {'nombrePremio': "Anotadores", 'cantidadPremio': "15", 'colorPremio': "76D7C4"},
        {'nombrePremio': "Hoppie Gris", 'cantidadPremio': "6", 'colorPremio': "73C6B6"},
        {'nombrePremio': "Hoppie de Colores ", 'cantidadPremio': "6", 'colorPremio': "7DCEA0"},
        // {'nombrePremio': "Portatarjeta", 'cantidadPremio': "2", 'colorPremio': "7FB3D5"},
        // {'nombrePremio': "Agendas", 'cantidadPremio': "2", 'colorPremio': "85C1E9"},
        // {'nombrePremio': "Anotadores", 'cantidadPremio': "2", 'colorPremio': "76D7C4"},
        // {'nombrePremio': "Hoppie Gris", 'cantidadPremio': "1", 'colorPremio': "73C6B6"},
        // {'nombrePremio': "Hoppie de Colores ", 'cantidadPremio': "1", 'colorPremio': "7DCEA0"},
      ];
      pref.remove("memoryListaPremios");
      pref.remove("saludo");
      pref.setString("memoryListaPremios", jsonEncode(listaTemporal));
      widget.listaPremios = listaTemporal;

      pref.setString("saludo", "Hola desde la memoria");
    });
  }

  _borrarPreferencias() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> _premiosVacios = [
      {"nombrePremio": "Sin Premios", "cantidadPremio": "100", "colorPremio": "b74093"},
      {"nombrePremio": "Sin Premios", "cantidadPremio": "100", "colorPremio": "b74093"}
    ];
    setState(() {
      pref.remove("memoryListaPremios");
      pref.remove("saludo");
      widget.listaPremios = _premiosVacios;
    });
  }

  @override
  void initState() {
    // print(widget.listaPremios[0]["nombrePremio"].toString());
    // print(widget.listaPremios.toString());

    super.initState();
  }

  String nombre = "";
  String cantidad = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar / Modificar Premios"),
        backgroundColor: Colors.grey.shade400,
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 50),
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    child: Text("Actualizar Lista"),
                    onPressed: () {
                      _guardarPreferencias(widget.listaPremios);
                    }),
                ElevatedButton(
                    child: Text("Cargar Lista Default"),
                    onPressed: () async {
                      _defaultPreferencias();
                    }),
                ElevatedButton(
                    child: Text("Borrar Lista"),
                    onPressed: () async {
                      _borrarPreferencias();
                    })
              ],
            ),
            //Lista
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.listaPremios.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade100),
                  child: ListTile(
                    title: Text("Nombre: " + widget.listaPremios[index]["nombrePremio"]),
                    subtitle: Text("Cantidad: " + widget.listaPremios[index]["cantidadPremio"]),
                    trailing: Container(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: IconButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(HexColor(widget.listaPremios[index]["colorPremio"]))),
                              icon: Icon(Icons.color_lens),
                              onPressed: () {
                                ColorPicker(
                                    color: HexColor(widget.listaPremios[index]["colorPremio"]),
                                    showColorCode: true,
                                    showColorValue: true,
                                    showColorName: true,
                                    onColorChanged: (Color color) {
                                      setState(() {
                                        widget.listaPremios[index]["colorPremio"] = color.hex.toString();
                                      });
                                    }).showPickerDialog(context);

                                print("Seleccionar Color: " + widget.listaPremios[index]["colorPremio"]);
                                print(widget.listaPremios.toString());
                              },
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.orange.shade300)),
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                print("Editar: " + widget.listaPremios[index]["nombrePremio"]);
                                showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    children: [
                                      TextField(
                                        controller: TextEditingController(text: widget.listaPremios[index]["nombrePremio"]),
                                        decoration: InputDecoration(labelText: "Nombre del Premio"),
                                        onChanged: (value) {
                                          setState(() {
                                            // nombre = value;
                                            widget.listaPremios[index]["nombrePremio"] = value;
                                          });
                                        },
                                      ),
                                      TextField(
                                        controller: TextEditingController(text: widget.listaPremios[index]["cantidadPremio"]),
                                        decoration: InputDecoration(labelText: "Cantidad"),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          setState(() {
                                            // cantidad = value.toString();
                                            widget.listaPremios[index]["cantidadPremio"] = value.toString();
                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // setState(() {
                                          //   widget.listaPremios[index]["nombrePremio"] = nombre;
                                          //   widget.listaPremios[index]["cantidadPremio"] = cantidad;
                                          // });
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cerrar"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade300)),
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  widget.listaPremios.removeAt(index);
                                });
                                print("Eliminando: " + widget.listaPremios[index]["nombrePremio"]);
                                print(widget.listaPremios.toString());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Nombre del Premio"),
                    onChanged: (value) {
                      setState(() {
                        if (value == null) {
                          nombre = "vacio";
                        } else {
                          nombre = value;
                        }
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Cantidad"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        if (value == null) {
                          cantidad = "0";
                        } else {
                          cantidad = value.toString();
                        }
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.listaPremios.add(
                          {"nombrePremio": "${nombre}", "cantidadPremio": "${cantidad}", "colorPremio": "b74093"},
                        );
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Agregar Premio"),
                  ),
                ],
              ),
            );
          }),
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
