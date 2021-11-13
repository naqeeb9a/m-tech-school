import 'package:flutter/material.dart';

import 'dynamic_sizes.dart';

customLoader(context, {color}) {
  return Center(
    child: SizedBox(
      width: dynamicWidth(context, 0.3),
      child: LinearProgressIndicator(
        color: color,
      ),
    ),
  );
}
