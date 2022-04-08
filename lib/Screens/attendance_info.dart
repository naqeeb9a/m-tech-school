import 'package:flutter/material.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/retry.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../api/api.dart';
import '../utils/app_routes.dart';
import '../utils/config.dart';
import '../widgets/loaders.dart';
import 'all_attendance.dart';

class AttendanceInfo extends StatefulWidget {
  final String school, studentId;
  const AttendanceInfo(
      {Key? key, required this.school, required this.studentId})
      : super(key: key);

  @override
  State<AttendanceInfo> createState() => _AttendanceInfoState();
}

class _AttendanceInfoState extends State<AttendanceInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: dynamicWidth(context, 0.55),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.indigo.withOpacity(0.6),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 8,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: FutureBuilder(
            future: ApiData().getStudentDetails(
                "attendanceSummary", widget.school, widget.studentId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == false) {
                  return Retry(
                    setState: () {
                      setState(() {});
                    },
                    color: Colors.white,
                    textColor: myBlack,
                  );
                } else {
                  var newData = snapshot.data;
                  for (var item in snapshot.data["data"]) {
                    if (item["is_active"] == 1) {
                      newData = item;
                    }
                  }
                  return Stack(
                    children: [
                      SizedBox(
                        height: dynamicWidth(context, 0.5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                color: myWhite.withOpacity(0.7),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      newData["_MonthYear"],
                                      style: const TextStyle(
                                          color: myBlack,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        push(
                                            context,
                                            TotalAttendance(
                                                school: widget.school,
                                                id: widget.studentId));
                                      },
                                      child: const Text(
                                        "See all",
                                        style: TextStyle(
                                            color: myBlack,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  percentColumn(
                                      context,
                                      "Presents",
                                      newData["_Presents"].toString() + "%",
                                      double.parse(newData["_Presents"]) / 100,
                                      7,
                                      Colors.green),
                                  percentColumn(
                                      context,
                                      "Absents",
                                      newData["_Absents"].toString() + "%",
                                      double.parse(newData["_Absents"]) / 100,
                                      7,
                                      Colors.red),
                                  percentColumn(
                                      context,
                                      "Leaves",
                                      newData["_Leaves"].toString() + "%",
                                      double.parse(newData["_Leaves"]) / 100,
                                      7,
                                      Colors.deepOrangeAccent)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: -3,
                          right: 0,
                          child: Image.asset(
                            "assets/attendance.png",
                            width: dynamicWidth(context, 0.15),
                          ))
                    ],
                  );
                }
              } else {
                return customLoader(context, color: myWhite);
              }
            }));
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
                color: myWhite,
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
                  color: myWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: dynamicWidth(context, 0.04))),
          progressColor: percentColor,
          circularStrokeCap: CircularStrokeCap.round,
        )
      ],
    );
  }
}
