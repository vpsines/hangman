import 'package:flutter/material.dart';

class HangMan extends StatelessWidget {
  final Size size;
  const HangMan({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: size.height,
      padding: const EdgeInsets.all(12),
      child: CustomPaint(
        painter: HangManPainter(),
        size: Size(270 - 24, size.height - 24),
      ),
    );
  }
}

enum Limb { left, right }

class HangManPainter extends CustomPainter {
  final double _headHeight = 32;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.fill;

    _drawFrame(canvas, size, paint);
    _drawNoose(canvas, size, paint);
    _drawHead(canvas, size, paint);
    _drawBody(canvas, size, paint);
    _drawLeg(canvas, size, paint, Limb.left);
    _drawLeg(canvas, size, paint, Limb.right);
    _drawHand(canvas, size, paint, Limb.left);
    _drawHand(canvas, size, paint, Limb.right);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  /// draws noose of hangman
  _drawNoose(Canvas canvas, Size size, Paint paint) {
    var nooseStart = Offset(size.width / 2, 0);
    var nooseEnd = Offset(size.width / 2, size.height / 5);

    paint.strokeWidth = 8.0;
    canvas.drawLine(nooseStart, nooseEnd, paint);
  }

  /// draws frame stand
  _drawFrame(Canvas canvas, Size size, Paint paint) {
    canvas.drawRect(Rect.fromLTRB(0, size.height, 12, 0), paint);
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width / 2, 12), paint);
  }

  /// draws head of hangman
  _drawHead(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    var nooseEnd = Offset(size.width / 2, size.height / 5);
    canvas.drawCircle(nooseEnd, _headHeight, paint);
  }

  /// draws body of hangman
  _drawBody(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.white;

    var bodyStart = Offset(size.width / 2, size.height / 5 + _headHeight);
    var bodyEnd = Offset(size.width / 2, bodyStart.dy + (3 * _headHeight));

    paint.strokeWidth = 8.0;
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 2, (bodyStart.dy + bodyEnd.dy) / 2),
            width: _headHeight * 2,
            height: _headHeight * 3),
        paint);
  }

  /// draws hangmans leg
  _drawLeg(Canvas canvas, Size size, Paint paint, Limb limb) {
    paint.color = Colors.white;

    var bodyStart = Offset(size.width / 2, size.height / 5 + _headHeight);

    var dxStart = limb == Limb.left ? size.width / 2 - 16 : size.width / 2 + 16;
    var legStart = Offset(dxStart, bodyStart.dy + (3 * _headHeight));

    var dxEnd = limb == Limb.left ? size.width / 2 - 32 : size.width / 2 + 32;
    var legEnd = Offset(dxEnd, legStart.dy + (3 * _headHeight));

    paint.strokeWidth = 8.0;
    canvas.drawLine(legStart, legEnd, paint);
  }

  /// draws hangmans hand
  _drawHand(Canvas canvas, Size size, Paint paint, Limb limb) {
    paint.color = Colors.black;

    var bodyStart = Offset(size.width / 2, size.height / 5 + _headHeight);

    var dxStart = limb == Limb.left ? size.width / 2 - 16 : size.width / 2 + 16;
    var handStart = Offset(dxStart, bodyStart.dy);

    var dxEnd = limb == Limb.left ? size.width / 2 - 64 : size.width / 2 + 64;
    var handEnd = Offset(dxEnd, handStart.dy + (2.5 * _headHeight));

    paint.strokeWidth = 8.0;
    canvas.drawLine(handStart, handEnd, paint);
  }
}
