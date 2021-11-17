import 'package:flutter/material.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
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
      body: Padding(
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
                    if (snapshot.data == false) {
                      return const Center(
                          child: Text("Server Error contact Yashir"));
                    } else {
                      return upperCards(
                        context,
                        snapshot.data["data"],
                      );
                    }
                    // ListView.builder(
                    //   scrollDirection: Axis.horizontal,
                    //   itemCount: snapshot.data["data"].length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return
                    //     InkWell(
                    //       onTap: () async {},
                    //       child: Container(
                    //         margin: EdgeInsets.symmetric(
                    //             horizontal: dynamicWidth(context, 0.02)),
                    //         padding:
                    //             EdgeInsets.all(dynamicWidth(context, 0.01)),
                    //         width: dynamicWidth(context, 0.3),
                    //         decoration: BoxDecoration(
                    //             color: Colors.amber,
                    //             borderRadius: BorderRadius.circular(15)),
                    //         child: Center(
                    //           child: Text(
                    //             snapshot.data["data"][index]["title"],
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                  } else {
                    return customLoader(context, color: myBlack);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

upperCards(context, snapshot, {pageController}) {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  return Container(
    margin: EdgeInsets.only(
      top: dynamicHeight(context, .01),
    ),
    child: PageView(
      physics: const BouncingScrollPhysics(),
      controller: pageController,
      scrollDirection: Axis.horizontal,
      children: List.generate(
        snapshot.length,
        (int index) => Container(
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
              Text(snapshot[index]["title"]),
              SizedBox(
                height: dynamicHeight(context, 0.05),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(dynamicWidth(context, 0.04)),
                  child: SfPdfViewer.network(
                    'https://portal.isl.school/parent/exams/export-student-report-card.php?School=5&Session=1&Class=17&Exam=15&Student=709&Status=A&PStatus=A',
                    key: _pdfViewerKey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
