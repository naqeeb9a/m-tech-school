import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/clip_paths.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/loaders.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatefulWidget {
  final String school;
  final String id;
  const AttendancePage({Key? key, required this.id, required this.school})
      : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool showCheck = false;
  dynamic selectedDate;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    CalendarCarousel _calendarCarouselNoHeader;

    double cHeight = MediaQuery.of(context).size.height;

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onDayPressed: (date, events) {
        setState(() {
          selectedDate = formatter.format(date);
          showCheck = true;
        });
      },
      height: cHeight * 0.54,
      weekendTextStyle: const TextStyle(
        color: primaryPink,
      ),
      weekdayTextStyle: const TextStyle(
        color: myBlack,
        fontWeight: FontWeight.bold,
      ),
      daysTextStyle: const TextStyle(color: myBlack),
      todayTextStyle: const TextStyle(
        color: myWhite,
      ),
      iconColor: myBlack,
      headerTextStyle: TextStyle(
        color: myBlack,
        fontSize: dynamicWidth(context, .05),
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      todayButtonColor: myBlack,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: null,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar("Attendance"),
      body: Stack(
        alignment: Alignment.center,
        children: [
          ClipPath(
            clipper: MyClipper(true),
            child: Container(
              color: primaryPurple,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: dynamicHeight(context, .05),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  width: dynamicWidth(context, .9),
                  height: dynamicHeight(context, .5),
                  decoration: BoxDecoration(
                    color: primaryLitePurple,
                    borderRadius: BorderRadius.circular(
                      dynamicWidth(context, .04),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: myBlack.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: _calendarCarouselNoHeader,
                  ),
                ),
                (showCheck == true)
                    ? SizedBox(
                        height: dynamicHeight(context, 0.2),
                        child: FutureBuilder(
                            future: ApiData().getStudentDetails(
                                "attendance", widget.school, widget.id),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data == false ||
                                    snapshot.data == null) {
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
                                } else if (snapshot.data["data"].length == 0) {
                                  return const Center(
                                    child: Text("No attendance Yet!"),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: ListView.builder(
                                        itemCount: snapshot.data["data"].length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (snapshot.data["data"][index]
                                                  ["date"] ==
                                              selectedDate) {
                                            return Container(
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: (snapshot.data["data"]
                                                            [index]["status"] ==
                                                        "A")
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                              height:
                                                  dynamicHeight(context, 0.1),
                                              width: dynamicWidth(context, 0.3),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot.data["data"][index]
                                                            ["subject_name"]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    snapshot.data["data"][index]
                                                            ["time"]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    snapshot.data["data"][index]
                                                            ["date"]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    snapshot.data["data"][index]
                                                            ["status"]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                  );
                                }
                              } else {
                                return customLoader(context);
                              }
                            }),
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
