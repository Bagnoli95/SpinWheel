import 'package:flutter/material.dart';

class MyParachutes extends StatelessWidget {
  MyParachutes({super.key, required this.MyHeight, required this.MyWidth, required this.MyDirection});

  double MyHeight;
  double MyWidth;
  bool MyDirection;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      alignment: Alignment.center,
      height: MyHeight,
      width: MyWidth,
      child: MyDirection
          ? Image.asset(
              'assets/parachutesSticker2.png',
              fit: BoxFit.fill,
            )
          : Image.asset(
              'assets/parachutesLeftSticker2.png',
              fit: BoxFit.fill,
            ),
    );
  }
}
