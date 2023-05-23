import 'dart:math';

import 'package:flutter/material.dart';

import 'customclipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
      angle: -pi / 3.3,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * .4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFdd0130), Color(0xFFdd0130)])),
        ),
      ),
    ));
  }
}
