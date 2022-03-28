import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:mtech_school_app/utils/config.dart';

class ApiData {
  getStudentDetails(query, school, studentId) async {
    var url =
        Uri.https('$schoolName.cmcmtech.com', '$query/$school/$studentId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return false;
    }
  }

  getStudentExamDetails(query, school, examId, studentId) async {
    var url = Uri.https(
        "$schoolName.cmcmtech.com", '$query/$school/$examId/$studentId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } else {
      return false;
    }
  }
}
