import 'package:flutter/material.dart';
import 'package:mtech_school_app/utils/essential_functions.dart';
import 'package:mtech_school_app/utils/student_data_calls.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';

class EventsPage extends StatelessWidget {
  final String school;
  final String id;
  const EventsPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar("Events"),
      body: FutureBuilder(
        future: getStudentDetails("events", school, id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context, index) {
                  return eventPageCards(context, index, snapshot);
                });
          } else {
            return Center(
              child: SizedBox(
                width: dynamicWidth(context, 0.3),
                child: const LinearProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
