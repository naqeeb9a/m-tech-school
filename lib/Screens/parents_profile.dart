import 'package:flutter/material.dart';
import 'package:mtech_school_app/Screens/events_page.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class ParentsProfile extends StatefulWidget {
  final String school;
  final String id;
  const ParentsProfile({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  _ParentsProfileState createState() => _ParentsProfileState();
}

class _ParentsProfileState extends State<ParentsProfile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: myGrey,
        body: Stack(
          children: [
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
                        child: const Icon(
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
                                                          widget.school,
                                                          widget.id),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      return tabViewCustomCards(
                                                          context,
                                                          snapshot.data);
                                                    } else {
                                                      return customLoader(
                                                          context);
                                                    }
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
                                                          widget.school,
                                                          widget.id),
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
                                                          widget.school,
                                                          widget.id),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return tabViewCustomCards(
                                                          context,
                                                          snapshot.data);
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

tabViewCustomCards(context, snapshot) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      tabViewCustomCardsColumn(context, check: true),
      tabViewCustomCardsColumn(
        context,
        check: true,
        text: ":",
        text1: ":",
        text2: ":",
        text3: ":",
        text4: ":",
        text5: ":",
        text6: ":",
        text7: ":",
        text8: ":",
        text9: ":",
        text10: ":",
        text11: ":",
        text12: ":",
      ),
      tabViewCustomCardsColumn(
        context,
        snapshot: snapshot,
      )
    ],
  );
}

tabViewCustomCardsColumn(context,
    {snapshot = "",
    text = "Name",
    text1 = "CNIC",
    text2 = "NTN",
    text3 = "Marital Status",
    text4 = "Qualification",
    text5 = "Company",
    text6 = "Department",
    text7 = "Designation",
    text8 = "Address",
    text9 = "Postal Code",
    text10 = "Phone",
    text11 = "Mobile",
    text12 = "Email",
    check = false}) {
  return SizedBox(
    height: dynamicHeight(context, 0.4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text((check == true) ? text : snapshot["father"]["name"]),
        Text((check == true) ? text1 : snapshot["father"]["cnic_no"]),
        Text((check == true) ? text2 : snapshot["father"]["ntn"]),
        Text((check == true) ? text3 : snapshot["father"]["marital_status"]),
        Text((check == true) ? text4 : snapshot["father"]["email"]),
        Text((check == true) ? text5 : snapshot["father"]["qualification"]),
        Text((check == true) ? text6 : snapshot["father"]["company"]),
        Text((check == true) ? text7 : snapshot["father"]["department"]),
        Text((check == true) ? text8 : snapshot["father"]["designation"]),
        Text((check == true) ? text9 : snapshot["father"]["address"]),
        Text((check == true) ? text10 : snapshot["father"]["postal_code"]),
        Text((check == true) ? text11 : snapshot["father"]["phone"]),
        Text((check == true) ? text12 : snapshot["father"]["mobile"]),
      ],
    ),
  );
}
