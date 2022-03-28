import 'package:flutter/material.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/clip_paths.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/loaders.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../api/api.dart';

class TotalAttendance extends StatelessWidget {
  final String school;
  final String id;
  const TotalAttendance({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar("Total attendance"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(false),
            child: Container(
              color: Colors.indigo,
            ),
          ),
          FutureBuilder(
            future:
                ApiData().getStudentDetails("attendanceSummary", school, id),
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
                  return ListView.builder(
                    itemCount: snapshot.data["data"].length,
                    itemBuilder: (context, index) {
                      return AllAttendance(
                        snapshot: snapshot.data,
                        index: index,
                      );
                    },
                  );
                }
              } else {
                return customLoader(
                  context,
                  color: Colors.white,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class AllAttendance extends StatelessWidget {
  final dynamic snapshot, index;
  const AllAttendance({Key? key, required this.snapshot, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: dynamicWidth(context, 0.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: myWhite,
          boxShadow: [
            BoxShadow(
              color: myBlack.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 8,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: myGrey.withOpacity(0.7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      snapshot["data"][index]["_MonthYear"],
                      style: const TextStyle(
                          color: myBlack, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  percentColumn(
                      context,
                      "Presents",
                      snapshot["data"][index]["_Presents"].toString() + "%",
                      double.parse(snapshot["data"][index]["_Presents"]) / 100,
                      7,
                      Colors.green),
                  percentColumn(
                      context,
                      "Absents",
                      snapshot["data"][index]["_Absents"].toString() + "%",
                      double.parse(snapshot["data"][index]["_Absents"]) / 100,
                      7,
                      Colors.red),
                  percentColumn(
                      context,
                      "Leaves",
                      snapshot["data"][index]["_Leaves"].toString() + "%",
                      double.parse(snapshot["data"][index]["_Leaves"]) / 100,
                      7,
                      Colors.deepOrangeAccent)
                ],
              ),
            ),
          ],
        ));
  }

  Widget percentColumn(BuildContext context, String text, String percentText,
      double percent, double lineWidth, Color percentColor) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: myBlack,
                fontWeight: FontWeight.bold,
                fontSize: dynamicWidth(context, 0.04))),
        CircularPercentIndicator(
          radius: dynamicWidth(context, 0.1),
          lineWidth: lineWidth,
          animation: true,
          animationDuration: 1200,
          percent: percent,
          center: Text(percentText,
              style: TextStyle(
                  color: myBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: dynamicWidth(context, 0.04))),
          progressColor: percentColor,
          circularStrokeCap: CircularStrokeCap.round,
        )
      ],
    );
  }
}
