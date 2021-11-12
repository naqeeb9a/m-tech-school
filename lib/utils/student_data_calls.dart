import 'dart:convert';

import 'package:http/http.dart' as http;

getStudentDetails(query,school, id) async {
  var response = await http
      .get(Uri.parse("http://mschool.cmcmtech.com/$query/$school/$id"));
  var jsonData = jsonDecode(response.body);
  return jsonData;
}
