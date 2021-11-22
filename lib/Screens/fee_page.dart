import 'package:flutter/material.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/clip_paths.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/loaders.dart';

class FeeDetailPage extends StatelessWidget {
  final String school;
  final String id;

  const FeeDetailPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar("Fee Details"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(true),
            child: Container(
              color: primaryGreen,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: dynamicHeight(context, 0.02)),
              child: FutureBuilder(
                future: ApiData().getStudentDetails("fees", school, id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == false || snapshot.data == null) {
                      return Center(
                        child: Text(
                          "Server Error",
                          style: TextStyle(
                            color: myBlack,
                            fontSize: dynamicWidth(context, .06),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    } else {
                      return feeCards(snapshot);
                    }
                  } else {
                    return customLoader(context, color: myWhite);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
