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
    final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
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
            SizedBox(
              height: dynamicHeight(context, 0.1),
              child: FutureBuilder(
                future: ApiData().getStudentDetails("exams", school, id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async {},
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: dynamicWidth(context, 0.02)),
                            width: dynamicWidth(context, 0.3),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                snapshot.data["data"][index]["title"],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return customLoader(context, color: myBlack);
                  }
                },
              ),
            ),
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
    );
  }
}
