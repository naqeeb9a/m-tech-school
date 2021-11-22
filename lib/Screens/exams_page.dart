import 'package:flutter/material.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/clip_paths.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/loaders.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExamsPage extends StatelessWidget {
  final String school;
  final String id;

  const ExamsPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar("Exams"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(false),
            child: Container(
              color: primaryBlue,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dynamicWidth(context, 0.02),
                vertical: dynamicHeight(context, 0.02)),
            child: Column(
              children: [
                SizedBox(
                  height: dynamicHeight(context, 0.02),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: ApiData().getStudentDetails("exams", school, id),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == false || snapshot.data == null) {
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
                        } else {
                          return upperCards(
                              context, snapshot.data["data"], school, id);
                        }
                      } else {
                        return customLoader(context, color: myWhite);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

upperCards(context, snapshot, school, studentId) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(
        top: dynamicHeight(context, .01),
      ),
      child: PageView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: List.generate(
          snapshot.length,
          (int index) {
            final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
            return Container(
              margin: EdgeInsets.only(
                right: dynamicWidth(context, .04),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  dynamicWidth(context, .024),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    snapshot[index]["title"].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: dynamicHeight(context, 0.05),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        dynamicWidth(context, 0.04),
                      ),
                      child: FutureBuilder(
                        future: ApiData().getStudentExamDetails("examsByID",
                            school, snapshot[index]["id"], studentId),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot1) {
                          if (snapshot1.connectionState ==
                              ConnectionState.done) {
                            if (snapshot1.data == false) {
                              return const Text("Server Error");
                            } else {
                              return (snapshot1.data["report"] == null)
                                  ? const Center(
                                      child: Text("no Results Yet!!"),
                                    )
                                  : SfPdfViewer.network(
                                      snapshot1.data["report"],
                                      key: _pdfViewerKey,
                                    );
                            }
                          } else {
                            return customLoader(context, color: myBlack);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}
