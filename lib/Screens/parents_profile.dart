import 'package:flutter/material.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ParentsProfile extends StatefulWidget {
  const ParentsProfile({Key? key}) : super(key: key);

  @override
  _ParentsProfileState createState() => _ParentsProfileState();
}

class _ParentsProfileState extends State<ParentsProfile> {
  dynamic school, userId, userProfile;

  Future getPrefData() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString("loginInfo");
      school = pref.getString("school");
    });
  }

  @override
  void initState() {
    super.initState();
    getPrefData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: dynamicWidth(context, 1),
              height: dynamicHeight(context, 1),
              color: myGrey,
            ),
            Container(
              width: dynamicWidth(context, 1),
              height: dynamicHeight(context, .32),
              decoration: const BoxDecoration(
                color: myBlack,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(60, 16),
                ),
              ),
            ),
            Container(
              width: dynamicWidth(context, 1),
              height: dynamicHeight(context, 1),
              color: noColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppBar(
                    title: const Text("Profile"),
                    centerTitle: true,
                    backgroundColor: noColor,
                    elevation: 0.0,
                    actions: [
                      InkWell(
                        onTap: () async {
                          SharedPreferences saveUser =
                              await SharedPreferences.getInstance();
                          saveUser.clear();
                          // checkLoginStatus();
                        },
                        child: Icon(
                          Icons.logout,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      width: dynamicWidth(context, 1),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: dynamicHeight(context, .136),
                            ),
                            child: Container(
                              width: dynamicWidth(context, .9),
                              height: dynamicHeight(context, .7),
                              decoration: BoxDecoration(
                                color: myWhite,
                                borderRadius: BorderRadius.circular(
                                  dynamicHeight(context, .03),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: myBlack.withOpacity(0.2),
                                    spreadRadius: 4,
                                    blurRadius: 8,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(
                                dynamicHeight(context, .02),
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: dynamicWidth(context, .05),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: dynamicHeight(context, .1),
                                    child: AppBar(
                                      backgroundColor: noColor,
                                      elevation: 0.0,
                                      bottom: TabBar(
                                        labelColor: primaryBlue,
                                        unselectedLabelColor: primaryLiteBlue,
                                        labelStyle: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                        unselectedLabelStyle: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                        tabs: const [
                                          Tab(
                                            text: "Father",
                                          ),
                                          Tab(
                                            text: "Student",
                                          ),
                                          Tab(
                                            text: "Mother",
                                          ),
                                        ],
                                        indicator: MaterialIndicator(
                                          height: 2,
                                          topLeftRadius: 2,
                                          topRightRadius: 2,
                                          bottomLeftRadius: 2,
                                          bottomRightRadius: 2,
                                          tabPosition: TabPosition.bottom,
                                          horizontalPadding:
                                              dynamicWidth(context, .12),
                                          color: primaryBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        Container(
                                          color: myWhite,
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    dynamicHeight(context, .04),
                                                horizontal:
                                                    dynamicWidth(context, .04),
                                              ),
                                              child: FutureBuilder(
                                                  future: ApiData()
                                                      .getStudentDetails(
                                                          "parentsProfile",
                                                          school,
                                                          userId),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Name"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "CNIC No"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text("ntn"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Marital Status"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Qualification"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Company"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Department"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Designation"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Address"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Postal Code"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Phone"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Mobile"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Email"),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "name"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "cnic_no"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "ntn"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "marital_status"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "qualification"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "company"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "department"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "designation"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "address"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "postal_code"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "phone"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "mobile"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["father"]
                                                                          [
                                                                          "email"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                    return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: dynamicHeight(
                                                            context, .2),
                                                        horizontal:
                                                            dynamicWidth(
                                                                context, .2),
                                                      ),
                                                      child:
                                                          const LinearProgressIndicator(),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: myWhite,
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    dynamicHeight(context, .04),
                                                horizontal:
                                                    dynamicWidth(context, .04),
                                              ),
                                              child: FutureBuilder(
                                                  future: ApiData()
                                                      .getStudentDetails(
                                                          "profile",
                                                          school,
                                                          userId),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text((snapshot.data
                                                              as Map)["data"]
                                                          .toString());
                                                    }
                                                    return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: dynamicHeight(
                                                            context, .2),
                                                        horizontal:
                                                            dynamicWidth(
                                                                context, .2),
                                                      ),
                                                      child:
                                                          const LinearProgressIndicator(),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: myWhite,
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    dynamicHeight(context, .04),
                                                horizontal:
                                                    dynamicWidth(context, .04),
                                              ),
                                              child: FutureBuilder(
                                                  future: ApiData()
                                                      .getStudentDetails(
                                                          "parentsProfile",
                                                          school,
                                                          userId),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Name"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "CNIC No"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text("ntn"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Marital Status"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Qualification"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Company"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Department"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Designation"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Address"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Postal Code"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Phone"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Mobile"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                    "Email"),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child:
                                                                    Text(":"),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "name"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "cnic_no"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "ntn"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "marital_status"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "qualification"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "company"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "department"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "designation"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "address"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "postal_code"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "phone"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "mobile"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      dynamicHeight(
                                                                          context,
                                                                          .006),
                                                                ),
                                                                child: Text(
                                                                  (snapshot.data
                                                                              as Map)["mother"]
                                                                          [
                                                                          "email"]
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                    return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: dynamicHeight(
                                                            context, .2),
                                                        horizontal:
                                                            dynamicWidth(
                                                                context, .2),
                                                      ),
                                                      child:
                                                          const LinearProgressIndicator(),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: dynamicHeight(context, .06),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: dynamicHeight(context, .07),
                                  backgroundColor: primaryBlue,
                                  child: ClipOval(
                                    child: Icon(
                                      Icons.person,
                                      size: dynamicHeight(context, .1),
                                      color: myWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
