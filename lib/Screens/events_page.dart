import 'package:flutter/material.dart';
import 'package:mtech_school_app/utils/essential_functions.dart';
import 'package:mtech_school_app/utils/student_data_calls.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';

import 'fee_page.dart';

class EventsPage extends StatelessWidget {
  final String school;
  final String id;
  const EventsPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar("Events"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(false),
            child: Container(
              color: Colors.orange,
            ),
          ),
          FutureBuilder(
            future: getStudentDetails("events", school, id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data["data"].length,
                    itemBuilder: (context, index) {
                      return eventPageCards(context, index, snapshot);
                    });
              } else {
                return customLoader(context);
              }
            },
          ),
        ],
      ),
    );
  }
}

customLoader(context) {
  return Center(
    child: SizedBox(
      width: dynamicWidth(context, 0.3),
      child: const LinearProgressIndicator(),
    ),
  );
}
