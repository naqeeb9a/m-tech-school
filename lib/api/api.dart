import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class ApiData {
  getStudentDetails(dynamic query, school, id) async {
    var url = Uri.https('mschool.cmcmtech.com', '$query/$school/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      return jsonResponse;
    } else {
      return false;
    }
  }
}
