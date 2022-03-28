import 'package:flutter/material.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';

import '../widgets/clip_paths.dart';

class HomeWorkPage extends StatelessWidget {
  final String school;
  final String id;
  const HomeWorkPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar("Home Work"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(false),
            child: Container(
              color: Colors.deepOrange,
            ),
          ),
        ],
      ),
    );
  }
}
