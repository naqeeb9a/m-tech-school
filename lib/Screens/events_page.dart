import 'package:flutter/material.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/clip_paths.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/loaders.dart';

class EventsPage extends StatelessWidget {
  final String school;
  final String id;

  const EventsPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar("Events"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(false),
            child: Container(
              color: primaryOrange,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(context, .03),
            ),
            child: FutureBuilder(
              future: ApiData().getStudentDetails("events", school, id),
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
                  } else if (snapshot.data["data"].length == 0) {
                    return const Center(
                      child: Text("No events yet!!"),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data["data"].length,
                        itemBuilder: (context, index) {
                          return eventPageCards(context, index, snapshot);
                        });
                  }
                } else {
                  return customLoader(context, color: myBlack);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
