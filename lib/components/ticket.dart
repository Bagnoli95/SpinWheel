import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTicketWinner extends StatelessWidget {
  const MyTicketWinner({
    super.key,
    required Animation animacionTicket,
    required String tituloPremio,
    required String premio,
  })  : _animacionTicket = animacionTicket,
        _tituloPremio = tituloPremio,
        _premio = premio;

  final Animation _animacionTicket;
  final String _tituloPremio;
  final String _premio;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animacionTicket,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 135, horizontal: 150),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.scaleDown,
            image: AssetImage("assets/TicketPremio.png"),
          ),
          // color: Colors.amber,
          // borderRadius: const BorderRadius.all(Radius.elliptical(100, 200)),
          // border: Border.all(color: Colors.white, width: 5, strokeAlign: BorderSide.strokeAlignInside),
        ),
        child: Column(
          children: [
            SizedBox(height: 250),

            //Titulo del premio
            Text(_tituloPremio,
                style: GoogleFonts.lexend(
                    textStyle: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ))),
            // Text(
            //   _premio,
            //   style: const TextStyle(
            //     color: Colors.white,
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
      builder: (context, child) {
        return Transform.scale(
          scale: _animacionTicket.value,
          child: child,
        );
      },
    );
  }
}
