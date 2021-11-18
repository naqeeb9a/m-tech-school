import 'package:flutter/material.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/clip_paths.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar("Attendance"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(true),
            child: Container(
              color: primaryPurple,
            ),
          ),
        ],
      ),
    );
  }
}
