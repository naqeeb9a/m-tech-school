import 'package:flutter/material.dart';
import 'package:mtech_school_app/utils/student_data_calls.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';

class ExamsPage extends StatelessWidget {
  final String school;
  final String id;
  const ExamsPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getExamsDetails(school, id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
                itemCount: snapshot.data["data"].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Center(
                      child: Text(snapshot.data["data"][index]["title"]));
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
