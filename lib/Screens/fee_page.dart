import 'package:flutter/material.dart';
import 'package:mtech_school_app/Screens/events_page.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/utils/essential_functions.dart';
import 'package:mtech_school_app/utils/student_data_calls.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';

class FeeDetailPage extends StatelessWidget {
  final String school;
  final String id;

  const FeeDetailPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar("Fee Details"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(true),
            child: Container(
              color: const Color(0xff2ca896),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: dynamicHeight(context, 0.02)),
              child: FutureBuilder(
                future: getStudentDetails("fees", school, id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(dynamicWidth(context, 0.05)),
                          decoration: BoxDecoration(
                              color: myWhite,
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, 0.1)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Fee Challan"),
                              const Divider(
                                thickness: 1,
                                color: myBlack,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Months : " +
                                      snapshot.data["data"][index]["month"]
                                          .toString()),
                                  Text("Year : " +
                                      snapshot.data["data"][index]["year"]
                                          .toString()),
                                ],
                              ),
                              SizedBox(
                                height: dynamicHeight(context, 0.02),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [
                                      Text(
                                        "Amount : ",
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Challan : ",
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Time Span : ",
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: dynamicWidth(context, 0.4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data["data"][index]["amount"]
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          snapshot.data["data"][index]
                                              ["challan"],
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          snapshot.data["data"][index]["title"],
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return customLoader(context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  final bool sizeCustom;
  MyClipper(this.sizeCustom);
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height * 0.33);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, (sizeCustom == true) ? 0 : size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
