import 'package:flutter/material.dart';
import 'package:mtech_school_app/Screens/attendance_page.dart';
import 'package:mtech_school_app/Screens/events_page.dart';
import 'package:mtech_school_app/Screens/exams_page.dart';
import 'package:mtech_school_app/Screens/fee_page.dart';
import 'package:mtech_school_app/Screens/home_page.dart';
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
    if (saveUser.getString("loginInfo") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        id = saveUser.getString("loginInfo").toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_loading == true)
          ? Center(
              child: SizedBox(
                  width: dynamicWidth(context, 0.3),
                  child: const LinearProgressIndicator()),
            )
          : SafeArea(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dynamicWidth(context, 0.03),
                      vertical: dynamicHeight(context, 0.01)),
                  child: header(context, () async {
                    SharedPreferences saveUser =
                        await SharedPreferences.getInstance();
                    saveUser.clear();
                    checkLoginStatus();
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    categoryCard(
                        context,
                        0.35,
                        0.5,
                        0.33,
                        0.43,
                        Colors.lightBlue,
                        "EXAMS",
                        "123 Lessons 12 Subjects",
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
                        0.4,
                        0.5,
                        0.38,
                        0.43,
                        const Color(0xff2ca896),
                        "FEE DETAILS",
                        "123 practices 12 Example",
                        "assets/practice.png",
                        0.18,
                        0.5, function: () {
                      push(context, const FeeDetailPage());
                    }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    categoryCard(
                        context,
                        0.4,
                        0.5,
                        0.38,
                        0.43,
                        Colors.orange,
                        "EVENTS",
                        "123 practices 12 Example",
                        "assets/games.png",
                        0.2,
                        0.7,
                        check: true, function: () {
                      push(context, const EventsPage());
                    }),
                    categoryCard(
                        context,
                        0.35,
                        0.5,
                        0.33,
                        0.43,
                        Colors.deepPurple,
                        "ATTENDANCE",
                        "123 Lessons 12 Subjects",
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
