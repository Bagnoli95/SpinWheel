import 'package:flutter/material.dart';

class MyFortuneWheel extends StatelessWidget {
  const MyFortuneWheel({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SectorsPainter(),
    );
  }
}

class MyWinnerIndicator extends StatelessWidget {
  const MyWinnerIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: key,
      painter: WinnerPainter(),
    );
  }
}

class WinnerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    final double mainCircleDiameter = 500;

    final arcsRect = Rect.fromLTWH((mainCircleDiameter / 2) * -1, (mainCircleDiameter / 2) * -1, mainCircleDiameter, mainCircleDiameter);

    canvas.drawArc(
      arcsRect,
      5.689774000000001,
      0.593412,
      false,
      paint..color = Colors.black,
    );

    canvas.drawCircle(
      Offset(0, 0),
      50,
      paint..color = Colors.green,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SectorsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    final double mainCircleDiameter = 500;

    Offset circleOffset = Offset(0, 0);

    final arcsRect = Rect.fromLTWH((mainCircleDiameter / 2) * -1, (mainCircleDiameter / 2) * -1, mainCircleDiameter, mainCircleDiameter);

    final useCenter = true;

    List<Color> sectorColors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.teal, Colors.blue, Colors.indigo, Colors.purple, Colors.pink, Colors.amber];

    final double backCircleDiameter = 260;
    canvas.drawCircle(
      circleOffset,
      backCircleDiameter,
      paint..color = Colors.grey,
    );

    final double sweepAngle = 0.593412;
    double startAngle = 0.0349066;

    for (Color color in sectorColors) {
      canvas.drawArc(
        arcsRect,
        startAngle,
        sweepAngle,
        useCenter,
        paint..color = color,
      );
      print('color: $color. arcsRect: $arcsRect. startAngle: $startAngle. sweepAngle: $sweepAngle.');
      startAngle = startAngle + sweepAngle + 0.0349066;
    }

    final double innerCircleDiameter = 50;

    canvas.drawCircle(
      circleOffset,
      innerCircleDiameter,
      paint..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
