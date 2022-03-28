import 'package:flutter/material.dart';
import 'package:mtech_school_app/Screens/all_attendance.dart';
import 'package:mtech_school_app/Screens/attendance_page.dart';
import 'package:mtech_school_app/Screens/events_page.dart';
import 'package:mtech_school_app/Screens/exams_page.dart';
import 'package:mtech_school_app/Screens/fee_page.dart';
import 'package:mtech_school_app/Screens/homework_page.dart';
import 'package:mtech_school_app/Screens/notification_page.dart';
import 'package:mtech_school_app/Screens/parents_profile.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/app_routes.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/loaders.dart';
import 'package:mtech_school_app/widgets/login_logout.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String id = "";
  String school = "";
  String userName = "";
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context, function: () async {
      SharedPreferences saveUser = await SharedPreferences.getInstance();
      SharedPreferences saveUserSchool = await SharedPreferences.getInstance();
      SharedPreferences saveUserName = await SharedPreferences.getInstance();
      setState(() {
        id = saveUser.getString("loginInfo").toString();
        school = saveUserSchool.getString("school").toString();
        userName = saveUserName.getString("userName").toString();
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: Header(
        context: context,
        userName: userName,
        function: () {
          push(
            context,
            ParentsProfile(
              school: school,
              id: id,
            ),
          );
        },
      ),
      body: (_loading == true)
          ? customLoader(context)
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Attendance Info :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AttendanceInfo(
                      school: school,
                      studentId: id,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Student Info :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryCard(
                          context: context,
                          outerSizeH: 0.33,
                          outerSizeW: 0.5,
                          innerSizeH: 0.3,
                          innerSizeW: 0.45,
                          colorDynamic: primaryBlue,
                          text1: "EXAMS",
                          image: "assets/placeholder2.png",
                          imageH: 0.15,
                          imageW: 0.35,
                          function: () {
                            push(
                              context,
                              ExamsPage(
                                school: school,
                                id: id,
                              ),
                            );
                          },
                          dValue: 200,
                        ),
                        CategoryCard(
                            context: context,
                            outerSizeH: 0.38,
                            outerSizeW: 0.5,
                            innerSizeH: 0.35,
                            innerSizeW: 0.45,
                            colorDynamic: primaryGreen,
                            text1: "FEE DETAILS",
                            image: "assets/placeholder3.png",
                            imageH: 0.15,
                            imageW: 0.5,
                            function: () {
                              push(
                                context,
                                FeeDetailPage(
                                  school: school,
                                  id: id,
                                ),
                              );
                            },
                            dValue: 500),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryCard(
                          context: context,
                          outerSizeH: 0.38,
                          outerSizeW: 0.5,
                          innerSizeH: 0.35,
                          innerSizeW: 0.45,
                          colorDynamic: primaryOrange,
                          text1: "EVENTS",
                          image: "assets/placeholder.png",
                          imageH: 0.17,
                          imageW: 0.65,
                          check: true,
                          function: () {
                            push(
                              context,
                              EventsPage(
                                school: school,
                                id: id,
                              ),
                            );
                          },
                          dValue: 800,
                        ),
                        CategoryCard(
                          context: context,
                          outerSizeH: 0.33,
                          outerSizeW: 0.5,
                          innerSizeH: 0.3,
                          innerSizeW: 0.45,
                          colorDynamic: primaryPurple,
                          text1: "ATTENDANCE",
                          image: "assets/placeholder1.png",
                          imageH: 0.2,
                          imageW: 0.3,
                          check: true,
                          function: () {
                            push(
                              context,
                              AttendancePage(
                                school: school,
                                id: id,
                              ),
                            );
                          },
                          dValue: 1100,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryCard(
                          context: context,
                          outerSizeH: 0.33,
                          outerSizeW: 0.5,
                          innerSizeH: 0.3,
                          innerSizeW: 0.45,
                          colorDynamic: Colors.deepOrange,
                          text1: "HOME WORK",
                          image: "assets/homeWork.png",
                          imageH: 0.15,
                          imageW: 0.35,
                          function: () {
                            push(
                              context,
                              HomeWorkPage(
                                school: school,
                                id: id,
                              ),
                            );
                          },
                          dValue: 200,
                        ),
                        CategoryCard(
                            context: context,
                            outerSizeH: 0.38,
                            outerSizeW: 0.5,
                            innerSizeH: 0.35,
                            innerSizeW: 0.45,
                            colorDynamic: Colors.brown,
                            text1: "FEE DETAILS",
                            image: "assets/placeholder3.png",
                            imageH: 0.15,
                            imageW: 0.5,
                            function: () {
                              push(
                                context,
                                FeeDetailPage(
                                  school: school,
                                  id: id,
                                ),
                              );
                            },
                            dValue: 500),
                      ],
                    ),
                    SizedBox(
                      height: dynamicHeight(context, 0.03),
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: _loading == true
          ? null
          : FloatingActionButton(
              backgroundColor: primaryPink,
              onPressed: () {
                push(
                  context,
                  NotificationsPage(
                    school: school,
                    id: id,
                  ),
                );
              },
              child: const Icon(Icons.notifications),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class AttendanceInfo extends StatelessWidget {
  final String school, studentId;
  const AttendanceInfo(
      {Key? key, required this.school, required this.studentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: dynamicWidth(context, 0.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.indigo.withOpacity(0.6),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 8,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: FutureBuilder(
            future: ApiData()
                .getStudentDetails("attendanceSummary", school, studentId),
            builder: (context, AsyncSnapshot snapshot) {
              var newData = snapshot.data;
              if (snapshot.connectionState == ConnectionState.done) {
                for (var item in snapshot.data["data"]) {
                  if (item["is_active"] == 1) {
                    newData = item;
                  }
                }
                return Column(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              newData["_MonthYear"],
                              style: const TextStyle(
                                  color: myBlack, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                push(
                                    context,
                                    TotalAttendance(
                                        school: school, id: studentId));
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                );
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
