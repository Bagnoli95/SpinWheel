import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //FOOTER
        ClipPath(
          clipper: WaveClipperTwo(reverse: false, flip: false),
          child: Container(
            color: Colors.blue[400],
            height: 80,
            width: double.maxFinite,
          ),
        ),
        ClipPath(
          clipper: WaveClipperOne(reverse: false, flip: true),
          child: Container(
            color: Colors.blue[300],
            height: 80,
            width: double.maxFinite,
          ),
        ),
        ClipPath(
          clipper: WaveClipperTwo(reverse: false, flip: true),
          child: Container(
            color: Colors.blue[200],
            height: 80,
            width: double.maxFinite,
          ),
        ),
      ],
    );
  }
}

class MyFooter extends StatelessWidget {
  const MyFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //FOOTER
        ClipPath(
          clipper: WaveClipperTwo(reverse: true, flip: true),
          child: Container(
            color: Colors.blue[400],
            height: 80,
            width: double.maxFinite,
          ),
        ),
        ClipPath(
          clipper: WaveClipperOne(reverse: true),
          child: Container(
            color: Colors.blue[300],
            height: 80,
            width: double.maxFinite,
          ),
        ),

        ClipPath(
          clipper: WaveClipperTwo(reverse: true),
          child: Container(
            color: Colors.blue[200],
            height: 80,
            width: double.maxFinite,
          ),
        ),
      ],
    );
  }
}
