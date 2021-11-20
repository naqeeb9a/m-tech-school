import 'package:flutter/material.dart';
import 'package:mtech_school_app/api/api.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/clip_paths.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/loaders.dart';

class FeeDetailPage extends StatelessWidget {
  final String school;
  final String id;

  const FeeDetailPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar("Fee Details"),
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(true),
            child: Container(
              color: primaryGreen,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: dynamicHeight(context, 0.02)),
              child: FutureBuilder(
                future: ApiData().getStudentDetails("fees", school, id),
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
                      return feeCards(snapshot);
                    }
                  } else {
                    return customLoader(context, color: myWhite);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget feeCards(snapshot) {
  return ListView.builder(
    itemCount: snapshot.data["data"].length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        padding: EdgeInsets.all(dynamicWidth(context, 0.05)),
        decoration: BoxDecoration(
            color: myWhite,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, 0.1),
            vertical: dynamicHeight(context, 0.02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Fee Challan"),
            const Divider(
              thickness: 1,
              color: myBlack,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Months : " +
                    snapshot.data["data"][index]["month"].toString()),
                Text("Year : " +
                    snapshot.data["data"][index]["year"].toString()),
              ],
            ),
            SizedBox(
              height: dynamicHeight(context, 0.02),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "Amount : ",
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Deduction : ",
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Time Span : ",
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(
                  width: dynamicWidth(context, 0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data["data"][index]["amount"].toString(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        snapshot.data["data"][index]["deduction"].toString(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        snapshot.data["data"][index]["title"].toString(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
