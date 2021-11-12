import 'package:flutter/material.dart';
import 'package:mtech_school_app/utils/config.dart';
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

eventPageCards(context, index, snapshot) {
  return Container(
    margin: EdgeInsets.symmetric(
        vertical: dynamicHeight(context, 0.01),
        horizontal: dynamicWidth(context, 0.1)),
    height: dynamicHeight(context, 0.25),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), border: Border.all(width: 1)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          snapshot.data["data"][context]["title"],
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: dynamicWidth(context, 0.05),
              fontWeight: FontWeight.bold),
        ),
        const Divider(
          thickness: 1,
          color: myBlack,
        ),
        Text(snapshot.data["data"][index]["classes"]),
        Text(snapshot.data["data"][index]["venue"]),
        Text(snapshot.data["data"][index]["start_date_time"]),
        Text(snapshot.data["data"][index]["end_date_time"])
      ],
    ),
  );
}
