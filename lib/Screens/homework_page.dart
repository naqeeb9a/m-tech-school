import 'package:flutter/material.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';

import '../api/api.dart';
import '../widgets/clip_paths.dart';
import '../widgets/dynamic_sizes.dart';
import '../widgets/loaders.dart';
import 'notification_page.dart';

class HomeWorkPage extends StatelessWidget {
  final String school;
  final String id;
  const HomeWorkPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar("Home Work"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(false),
            child: Container(
              color: Colors.deepOrange,
            ),
          ),
          FutureBuilder(
            future: ApiData().getStudentDetails("homework", school, id),
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
                        return notificationsCard(
                            context,
                            snapshot.data["data"][index]["details"].toString(),
                            myGrey,
                            Colors.deepOrange,
                            Colors.deepOrange,
                            alignemnt: Alignment.topCenter);
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
