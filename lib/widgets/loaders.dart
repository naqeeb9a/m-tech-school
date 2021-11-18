import 'package:flutter/material.dart';
import 'package:mtech_school_app/utils/config.dart';

customLoader(context, {color = myBlack}) {
  return Center(
    child: Image.asset(
      "assets/loader.gif",
      color: color,
      scale: 4,
    ),
  );
}
