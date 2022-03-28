import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/loaders.dart';

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  dynamicWidth(context, .12),
                ),
                bottomRight: Radius.circular(
                  dynamicWidth(context, .12),
                ),
              ),
              color: primaryPink,
            ),
          ),
          FutureBuilder(
            future: ApiData().getStudentDetails("notifications", school, id),
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
                      if (snapshot.data["data"][index]["notice"].toString() !=
                          "") {
                        return notificationsCard(
                          context,
                          snapshot.data["data"][index]["notice"].toString(),
                          primaryLitePink,
                          primaryLitePink,
                          myBlack
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
                  color: primaryPink,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

notificationsCard(context, notice, color, color2,color2shadow,
    {alignemnt = Alignment.topRight}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: alignemnt,
        children: [
          Container(
            width: dynamicWidth(context, 0.85),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color,
              boxShadow: [
                BoxShadow(
                  color: myBlack.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.only(
                top: dynamicHeight(context, 0.08),
                bottom: dynamicHeight(context, 0.05),
                left: dynamicWidth(context, 0.05),
                right: dynamicWidth(context, 0.05)),
            margin: EdgeInsets.all(
              dynamicHeight(context, 0.03),
            ),
            child: Html(
              data: notice.toString(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color2shadow.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: CircleAvatar(
              radius: dynamicWidth(context, 0.11),
              backgroundColor: color2,
              child: CircleAvatar(
                radius: dynamicWidth(context, 0.1),
                backgroundColor: color,
                backgroundImage: const NetworkImage(
                  "https://1q3b4h3e3g3t30d8621ylzxr-wpengine.netdna-ssl.com/wp-content/uploads/2021/05/SAEL-Portrait-360x360.jpg",
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
