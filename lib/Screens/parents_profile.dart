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
                                        labelColor: myRed,
                                        unselectedLabelColor: myBlack,
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
                                          color: myRed,
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
                                                      .getFatherProfileData(
                                                    school,
                                                    userId,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(snapshot.data
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

                                                    // return ListView.builder(
                                                    //   itemCount: snapshot.data.length,
                                                    //   itemBuilder: (context, index) {
                                                    //     ProjectModel project = snapshot.data[index];
                                                    //     return Column(
                                                    //       children: <Widget>[
                                                    //         // Widget to display the list of project
                                                    //       ],
                                                    //     );
                                                    //   },
                                                    // );
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
                                                  future:
                                                      ApiData().getProfileData(
                                                    school,
                                                    userId,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(snapshot.data
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

                                                    // return ListView.builder(
                                                    //   itemCount: snapshot.data.length,
                                                    //   itemBuilder: (context, index) {
                                                    //     ProjectModel project = snapshot.data[index];
                                                    //     return Column(
                                                    //       children: <Widget>[
                                                    //         // Widget to display the list of project
                                                    //       ],
                                                    //     );
                                                    //   },
                                                    // );
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
                                                      .getMotherProfileData(
                                                    school,
                                                    userId,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(snapshot.data
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

                                                    // return ListView.builder(
                                                    //   itemCount: snapshot.data.length,
                                                    //   itemBuilder: (context, index) {
                                                    //     ProjectModel project = snapshot.data[index];
                                                    //     return Column(
                                                    //       children: <Widget>[
                                                    //         // Widget to display the list of project
                                                    //       ],
                                                    //     );
                                                    //   },
                                                    // );
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
                                  backgroundColor: Colors.blue,
                                  child: ClipOval(
                                    child: Icon(
                                      Icons.person,
                                      size: dynamicHeight(context, .1),
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

// SharedPreferences saveUser =
//     await SharedPreferences.getInstance();
// saveUser.clear();
// checkLoginStatus();

// SizedBox(
//   height: dynamicHeight(context, .14),
//   child: AppBar(
//     backgroundColor: noColor,
//     elevation: 0.0,
//     bottom: TabBar(
//       labelColor: myRed,
//       unselectedLabelColor: myBlack,
//       labelStyle: TextStyle(
//         fontWeight: FontWeight.w800,
//       ),
//       unselectedLabelStyle: TextStyle(
//         fontWeight: FontWeight.normal,
//       ),
//       tabs: [
//         Tab(
//           text: "Father",
//         ),
//         Tab(
//           text: "Student",
//         ),
//         Tab(
//           text: "Mother",
//         ),
//       ],
//       indicator: MaterialIndicator(
//         height: 2,
//         topLeftRadius: 2,
//         topRightRadius: 2,
//         bottomLeftRadius: 2,
//         bottomRightRadius: 2,
//         tabPosition: TabPosition.bottom,
//         horizontalPadding:
//             dynamicWidth(context, .12),
//         color: myRed,
//       ),
//     ),
//   ),
// ),
// Expanded(
//   child: TabBarView(
//     children: [
//       Container(
//         color: myWhite,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: dynamicHeight(context, .04),
//               horizontal:
//                   dynamicWidth(context, .04),
//             ),
//             child: FutureBuilder(
//                 future:
//                     ApiData().getFatherProfileData(
//                   school,
//                   userId,
//                 ),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(
//                         snapshot.data.toString());
//                   }
//                   return Center(
//                     child:
//                         LinearProgressIndicator(),
//                   );
//
//                   // return ListView.builder(
//                   //   itemCount: snapshot.data.length,
//                   //   itemBuilder: (context, index) {
//                   //     ProjectModel project = snapshot.data[index];
//                   //     return Column(
//                   //       children: <Widget>[
//                   //         // Widget to display the list of project
//                   //       ],
//                   //     );
//                   //   },
//                   // );
//                 }),
//           ),
//         ),
//       ),
//       Container(
//         color: myWhite,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: dynamicHeight(context, .04),
//               horizontal:
//                   dynamicWidth(context, .04),
//             ),
//             child: FutureBuilder(
//                 future: ApiData().getProfileData(
//                   school,
//                   userId,
//                 ),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(
//                         snapshot.data.toString());
//                   }
//                   return Center(
//                     child:
//                         LinearProgressIndicator(),
//                   );
//
//                   // return ListView.builder(
//                   //   itemCount: snapshot.data.length,
//                   //   itemBuilder: (context, index) {
//                   //     ProjectModel project = snapshot.data[index];
//                   //     return Column(
//                   //       children: <Widget>[
//                   //         // Widget to display the list of project
//                   //       ],
//                   //     );
//                   //   },
//                   // );
//                 }),
//           ),
//         ),
//       ),
//       Container(
//         color: myWhite,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: dynamicHeight(context, .04),
//               horizontal:
//                   dynamicWidth(context, .04),
//             ),
//             child: FutureBuilder(
//                 future:
//                     ApiData().getMotherProfileData(
//                   school,
//                   userId,
//                 ),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(
//                         snapshot.data.toString());
//                   }
//                   return Center(
//                     child:
//                         LinearProgressIndicator(),
//                   );
//
//                   // return ListView.builder(
//                   //   itemCount: snapshot.data.length,
//                   //   itemBuilder: (context, index) {
//                   //     ProjectModel project = snapshot.data[index];
//                   //     return Column(
//                   //       children: <Widget>[
//                   //         // Widget to display the list of project
//                   //       ],
//                   //     );
//                   //   },
//                   // );
//                 }),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
