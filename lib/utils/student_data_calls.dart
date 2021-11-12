import 'dart:convert';

import 'package:http/http.dart' as http;

getExamsDetails(school, id) async {
  var response = await http
      .get(Uri.parse("http://mschool.cmcmtech.com/exams/$school/$id"));
  var jsonData = jsonDecode(response.body);
  print(jsonData);
  return jsonData;
}
