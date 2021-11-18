import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  final bool sizeCustom;

  MyClipper(this.sizeCustom);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, sizeCustom == true ? size.height * 0.7 : size.height * 0.2);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(
        size.width, sizeCustom == true ? size.height * .2 : size.height * .7);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
