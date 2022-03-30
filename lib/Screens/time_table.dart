import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/clip_paths.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';

import '../widgets/loaders.dart';

class TimeTable extends StatelessWidget {
  final String school;
  final String id;
  const TimeTable({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar("Time Table"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(false),
            child: Container(
              color: Colors.brown,
            ),
          ),
          FutureBuilder(
            future: ApiData().getStudentDetails("timetable", school, id),
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
                  return ListView.builder(
                    itemCount: snapshot.data["data"].length,
                    itemBuilder: (context, index) {
                      if (snapshot.data["data"][index]["details"].toString() !=
                          "") {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(snapshot.data["data"][index]["title"]),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(snapshot.data["data"][index]["date"]),
                            const SizedBox(
                              height: 10,
                            ),
                            HtmlWidget(snapshot.data["data"][index]["notice"]
                                .toString()
                                .replaceAll(r"\", ""))
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                }
              } else {
                return customLoader(
                  context,
                  color: Colors.white,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
