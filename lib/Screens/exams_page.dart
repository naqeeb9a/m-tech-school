import 'package:flutter/material.dart';
import 'package:mtech_school_app/utils/student_data_calls.dart';

class ExamsPage extends StatelessWidget {
  final String school;
  final String id;
  const ExamsPage({Key? key, required this.school, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getExamsDetails(school, id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(itemBuilder: (context, index) {
          return const ListTile();
        });
      },
    );
  }
}
