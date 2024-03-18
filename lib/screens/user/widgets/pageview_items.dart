import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.itemImage,
    required this.title,
    required this.description,
    required this.backGround,
    required this.txtColor,
  });

  final String itemImage;
  final String title;
  final String description;
  final Widget backGround;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        backGround,
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
            child: Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: screenSize.width * 0.3,
                    backgroundImage: AssetImage(itemImage),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: txtColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: txtColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PageViewBackgroundItem1 extends StatelessWidget {
  const PageViewBackgroundItem1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomPaint(
        size: Size(
          screenSize.width,
          screenSize.height,
        ),
        painter: RPSCustomPainterOne(),
      ),
    );
  }
}

class RPSCustomPainterOne extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    // ignore: non_constant_identifier_names
    Paint paint_fill_0 = Paint()
      ..color = const Color(0xff04516f)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0030556, size.height * 1.0022749);
    path_0.quadraticBezierTo(size.width * -0.0251319, size.height * 1.0065158,
        size.width * 0.0332546, size.height * 0.9741427);
    path_0.cubicTo(
        size.width * 0.0838241,
        size.height * 0.9478412,
        size.width * 0.1348519,
        size.height * 0.9424677,
        size.width * 0.2083380,
        size.height * 0.9339200);
    path_0.cubicTo(
        size.width * 0.3079491,
        size.height * 0.9242792,
        size.width * 0.4239074,
        size.height * 0.9448779,
        size.width * 0.5323287,
        size.height * 0.8935129);
    path_0.cubicTo(
        size.width * 0.6015880,
        size.height * 0.8566882,
        size.width * 0.6716111,
        size.height * 0.7902299,
        size.width * 0.8031019,
        size.height * 0.7854885);
    path_0.quadraticBezierTo(size.width * 0.8834375, size.height * 0.7827227,
        size.width * 1.0019167, size.height * 0.7974210);
    path_0.lineTo(size.width * 1.0032407, size.height * 1.0014847);
    path_0.lineTo(size.width * -0.0030556, size.height * 1.0022749);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color(0xff04516f)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PageViewBackgroundItem2 extends StatelessWidget {
  const PageViewBackgroundItem2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomPaint(
        size: Size(screenSize.width, screenSize.height),
        painter: RPSCustomPainterTwo(),
      ),
    );
  }
}

class RPSCustomPainterTwo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = const Color(0xff04516f)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0032593, size.height * 0.7974473);
    path_0.quadraticBezierTo(size.width * -0.0027245, size.height * 0.9500802,
        size.width * -0.0025463, size.height * 1.0009579);
    path_0.lineTo(size.width * 1.0006944, size.height * 0.9996408);
    path_0.quadraticBezierTo(size.width * 1.0034190, size.height * 0.2188278,
        size.width * 1.0034190, size.height * 0.0930496);
    path_0.cubicTo(
        size.width * 0.9123380,
        size.height * 0.0375623,
        size.width * 0.7793704,
        size.height * 0.0303712,
        size.width * 0.6743102,
        size.height * 0.0318726);
    path_0.cubicTo(
        size.width * 0.4909769,
        size.height * 0.0324916,
        size.width * 0.2154421,
        size.height * 0.1035201,
        size.width * 0.2682778,
        size.height * 0.3629789);
    path_0.cubicTo(
        size.width * 0.3276065,
        size.height * 0.7347557,
        size.width * 0.3136782,
        size.height * 0.7602143,
        size.width * 0.2673611,
        size.height * 0.7915469);
    path_0.cubicTo(
        size.width * 0.2158750,
        size.height * 0.8247629,
        size.width * 0.1121389,
        size.height * 0.8182304,
        size.width * -0.0032593,
        size.height * 0.7974473);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color(0xff04516f)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PageViewBackgroundItem3 extends StatelessWidget {
  const PageViewBackgroundItem3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomPaint(
        size: Size(screenSize.width, screenSize.height),
        painter: RPSCustomPainterThree(),
      ),
    );
  }
}

class RPSCustomPainterThree extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = const Color(0xff04516f)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0004838, size.height * 0.0927993);
    path_0.quadraticBezierTo(size.width * 0.0000509, size.height * 0.2454322,
        size.width * -0.0025463, size.height * 1.0009579);
    path_0.lineTo(size.width * 1.0006944, size.height * 0.9996408);
    path_0.quadraticBezierTo(size.width * 1.0034190, size.height * 0.1252646,
        size.width * 1.0034190, size.height * -0.0005136);
    path_0.cubicTo(
        size.width * 0.8341157,
        size.height * 0.0004741,
        size.width * 0.5626296,
        size.height * -0.0033453,
        size.width * 0.4575694,
        size.height * -0.0018439);
    path_0.cubicTo(
        size.width * 0.3638657,
        size.height * 0.0160548,
        size.width * 0.3707153,
        size.height * 0.0688159,
        size.width * 0.2999537,
        size.height * 0.1009914);
    path_0.cubicTo(
        size.width * 0.2435787,
        size.height * 0.1333645,
        size.width * 0.0969884,
        size.height * 0.1371839,
        size.width * -0.0004838,
        size.height * 0.0927993);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color(0xff04516f)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PageViewBackgroundItem4 extends StatelessWidget {
  const PageViewBackgroundItem4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xff04516f),
      ),
    );
  }
}
