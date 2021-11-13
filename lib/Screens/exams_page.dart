import 'package:flutter/material.dart';
import 'package:mtech_school_app/Screens/events_page.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';

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
                        return Container(
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
                          )),
                        );
                      },
                    );
                  } else {
                    return customLoader(context);
                  }
                },
              ),
            ),
            SizedBox(
              height: dynamicHeight(context, 0.05),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.all(dynamicWidth(context, 0.02)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
