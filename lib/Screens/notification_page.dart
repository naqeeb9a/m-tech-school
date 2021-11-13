import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mtech_school_app/Screens/events_page.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';

class NotificationsPage extends StatelessWidget {
  final String school;
  final String id;

  const NotificationsPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar("Notifications", check: true),
      body: Stack(
        children: [
          Container(
            height: dynamicHeight(context, 0.4),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                color: Colors.amber),
          ),
          Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future:
                      ApiData().getStudentDetails("notifications", school, id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data["data"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return notificationsCard(
                              context, index, snapshot.data["data"]);
                        },
                      );
                    } else {
                      return customLoader(context);
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

notificationsCard(context, index, snapshot) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: dynamicWidth(context, 0.85),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: myWhite),
            padding: EdgeInsets.all(dynamicWidth(context, 0.05)),
            // margin: EdgeInsets.only(top: dynamicHeight(context, 0.03)),
            margin: EdgeInsets.all(dynamicHeight(context, 0.03)),
            child: Html(data: snapshot[index]["notice"]),
          ),
          CircleAvatar(
              radius: dynamicWidth(context, 0.1),
              backgroundImage: const NetworkImage(
                "https://1q3b4h3e3g3t30d8621ylzxr-wpengine.netdna-ssl.com/wp-content/uploads/2021/05/SAEL-Portrait-360x360.jpg",
              )),
        ],
      ),
    ),
  );
}
