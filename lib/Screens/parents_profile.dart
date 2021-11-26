import 'package:flutter/material.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/loaders.dart';
import 'package:mtech_school_app/widgets/login_logout.dart';
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
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(60, 16),
                ),
                child: Image.asset(
                  "assets/profile_bg.jpg",
                  fit: BoxFit.fill,
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
                          SharedPreferences saveUserSchool =
                              await SharedPreferences.getInstance();
                          SharedPreferences saveUserName =
                              await SharedPreferences.getInstance();
                          saveUser.clear();
                          saveUserSchool.clear();
                          saveUserName.clear();
                          checkLoginStatus(
                            context,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: dynamicWidth(context, .04),
                          ),
                          child: const Icon(
                            Icons.logout,
                          ),
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
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  dynamicHeight(context, .04),
                                            ),
                                            child: FutureBuilder(
                                              future:
                                                  ApiData().getStudentDetails(
                                                "parentsProfile",
                                                widget.school,
                                                widget.id,
                                              ),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  if (snapshot.data == false ||
                                                      snapshot.data == null) {
                                                    return Center(
                                                      child: Text(
                                                        "Server Error",
                                                        style: TextStyle(
                                                          color: myBlack,
                                                          fontSize:
                                                              dynamicWidth(
                                                                  context, .06),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return tabViewCustomCards(
                                                      context,
                                                      snapshot.data,
                                                      "father",
                                                    );
                                                  }
                                                } else {
                                                  return customLoader(context,
                                                      color: myBlack);
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: myWhite,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  dynamicHeight(context, .04),
                                            ),
                                            child: FutureBuilder(
                                              future:
                                                  ApiData().getStudentDetails(
                                                "profile",
                                                widget.school,
                                                widget.id,
                                              ),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  if (snapshot.data == false ||
                                                      snapshot.data == null) {
                                                    return Center(
                                                      child: Text(
                                                        "Server Error",
                                                        style: TextStyle(
                                                          color: myBlack,
                                                          fontSize:
                                                              dynamicWidth(
                                                                  context, .06),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return studentTabViewCustomCards(
                                                      context,
                                                      snapshot.data,
                                                    );
                                                  }
                                                } else {
                                                  return customLoader(context,
                                                      color: myBlack);
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: myWhite,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  dynamicHeight(context, .04),
                                            ),
                                            child: FutureBuilder(
                                              future:
                                                  ApiData().getStudentDetails(
                                                "parentsProfile",
                                                widget.school,
                                                widget.id,
                                              ),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  if (snapshot.data == false ||
                                                      snapshot.data == null) {
                                                    return Center(
                                                      child: Text(
                                                        "Server Error",
                                                        style: TextStyle(
                                                          color: myBlack,
                                                          fontSize:
                                                              dynamicWidth(
                                                                  context, .06),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return tabViewCustomCards(
                                                      context,
                                                      snapshot.data,
                                                      "mother",
                                                    );
                                                  }
                                                } else {
                                                  return customLoader(context,
                                                      color: myBlack);
                                                }
                                              },
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

tabViewCustomCards(context, snapshot, parent) {
  return SingleChildScrollView(
    child: Row(
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
        tabViewCustomCardsColumn(context, snapshot: snapshot, parent: parent)
      ],
    ),
  );
}

tabViewCustomCardsColumn(context,
    {snapshot = "",
    parent = "",
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
        Text(
          check == true ? text : snapshot[parent]["name"].toString(),
        ),
        Text(
          check == true ? text1 : snapshot[parent]["cnic_no"].toString(),
        ),
        Text(
          check == true ? text2 : snapshot[parent]["ntn"].toString(),
        ),
        Text(
          check == true ? text3 : snapshot[parent]["marital_status"].toString(),
        ),
        Text(
          check == true ? text4 : snapshot[parent]["qualification"].toString(),
        ),
        Text(
          check == true ? text5 : snapshot[parent]["company"].toString(),
        ),
        Flexible(
          child: Text(
            check == true ? text6 : snapshot[parent]["department"].toString(),
          ),
        ),
        Text(
          check == true ? text7 : snapshot[parent]["designation"].toString(),
        ),
        (check == true)
            ? Text(
                check == true ? text8 : snapshot[parent]["address"].toString(),
                overflow: TextOverflow.ellipsis,
              )
            : SizedBox(
                width: dynamicWidth(context, 0.4),
                child: Text(
                  check == true
                      ? text8
                      : snapshot[parent]["address"].toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        Text(
          check == true ? text9 : snapshot[parent]["postal_code"].toString(),
        ),
        Text(
          check == true ? text10 : snapshot[parent]["phone"].toString(),
        ),
        Text(
          check == true ? text11 : snapshot[parent]["mobile"].toString(),
        ),
        Text(
          check == true ? text12 : snapshot[parent]["email"].toString(),
        ),
      ],
    ),
  );
}

studentTabViewCustomCards(context, snapshot) {
  return SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        studentTabViewCustomCardsColumn(context, check: true),
        studentTabViewCustomCardsColumn(
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
        studentTabViewCustomCardsColumn(context,
            snapshot: snapshot, parent: "data")
      ],
    ),
  );
}

studentTabViewCustomCardsColumn(context,
    {snapshot = "",
    parent = "",
    text = "Name",
    text1 = "Gender",
    text2 = "DOB",
    text3 = "Birth Place",
    text4 = "Disability",
    text5 = "Blood Group",
    text6 = "Hand",
    text7 = "Postal Code",
    text8 = "Address",
    text9 = "Registration No",
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
        Text(
          check == true ? text : snapshot[parent]["name"].toString(),
        ),
        Text(
          check == true ? text1 : snapshot[parent]["gender"].toString(),
        ),
        Text(
          check == true ? text2 : snapshot[parent]["dob"].toString(),
        ),
        Text(
          check == true ? text3 : snapshot[parent]["birth_place"].toString(),
        ),
        Text(
          check == true ? text4 : snapshot[parent]["disability"].toString(),
        ),
        Text(
          check == true ? text5 : snapshot[parent]["blood_group"].toString(),
        ),
        Text(
          check == true ? text6 : snapshot[parent]["hand"].toString(),
        ),
        Text(
          check == true ? text7 : snapshot[parent]["postal_code"].toString(),
        ),
        (check == true)
            ? Text(
                check == true ? text8 : snapshot[parent]["address"].toString(),
                overflow: TextOverflow.ellipsis,
              )
            : SizedBox(
                width: dynamicWidth(context, 0.4),
                child: Text(
                  check == true
                      ? text8
                      : snapshot[parent]["address"].toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        Text(
          check == true
              ? text9
              : snapshot[parent]["registration_no"].toString(),
        ),
        Text(
          check == true ? text10 : snapshot[parent]["phone"].toString(),
        ),
        Text(
          check == true ? text11 : snapshot[parent]["mobile"].toString(),
        ),
        Text(
          check == true ? text12 : snapshot[parent]["email"].toString(),
        ),
      ],
    ),
  );
}
