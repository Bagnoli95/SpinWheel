import 'package:flutter/material.dart';

class MyFiltro extends StatelessWidget {
  const MyFiltro({
    super.key,
    required Animation animacionFiltro,
  }) : _animacionFiltro = animacionFiltro;

  final Animation _animacionFiltro;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animacionFiltro,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(0.25),
          borderRadius: const BorderRadius.all(Radius.elliptical(100, 200)),
          border: Border.all(
            color: Colors.orange,
            width: 3,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
      ),
      builder: (context, child) {
        return Transform.scale(
          scale: _animacionFiltro.value,
          child: child,
        );
      },
    );
  }
}
