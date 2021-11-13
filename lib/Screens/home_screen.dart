import 'package:flutter/material.dart';
import 'package:mtech_school_app/Screens/attendance_page.dart';
import 'package:mtech_school_app/Screens/events_page.dart';
import 'package:mtech_school_app/Screens/exams_page.dart';
import 'package:mtech_school_app/Screens/fee_page.dart';
import 'package:mtech_school_app/Screens/login_page.dart';
import 'package:mtech_school_app/Screens/parents_profile.dart';
import 'package:mtech_school_app/utils/app_routes.dart';
import 'package:mtech_school_app/utils/essential_functions.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String id = "";
  String school = "";
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    SharedPreferences saveUser = await SharedPreferences.getInstance();
    SharedPreferences saveUserSchool = await SharedPreferences.getInstance();
    if (saveUser.getString("loginInfo") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        id = saveUser.getString("loginInfo").toString();
        school = saveUserSchool.getString("school").toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_loading == true)
          ? customLoader(context)
          : SafeArea(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dynamicWidth(context, 0.03),
                      vertical: dynamicHeight(context, 0.01)),
                  child: header(context, () {
                    push(
                      context,
                      const ParentsProfile(),
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    categoryCard(
                        context,
                        0.33,
                        0.5,
                        0.3,
                        0.45,
                        Colors.lightBlue,
                        "EXAMS",
                        "assets/teacher.png",
                        0.2,
                        0.3, function: () {
                      push(
                          context,
                          ExamsPage(
                            school: school,
                            id: id,
                          ));
                    }),
                    categoryCard(
                        context,
                        0.38,
                        0.5,
                        0.35,
                        0.45,
                        const Color(0xff2ca896),
                        "FEE DETAILS",
                        "assets/practice.png",
                        0.18,
                        0.5, function: () {
                      push(
                        context,
                        FeeDetailPage(
                          school: school,
                          id: id,
                        ),
                      );
                    }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    categoryCard(context, 0.38, 0.5, 0.35, 0.45, Colors.orange,
                        "EVENTS", "assets/games.png", 0.2, 0.7, check: true,
                        function: () {
                      push(
                          context,
                          EventsPage(
                            school: school,
                            id: id,
                          ));
                    }),
                    categoryCard(
                        context,
                        0.33,
                        0.5,
                        0.3,
                        0.45,
                        Colors.deepPurple,
                        "ATTENDANCE",
                        "assets/homework.png",
                        0.2,
                        0.4,
                        check: true, function: () {
                      push(context, const AttendancePage());
                    }),
                  ],
                )
              ],
            )),
    );
  }
}
