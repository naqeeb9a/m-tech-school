import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class ApiData {
  getProfileData(dynamic school, id) async {
    var url = Uri.https('mschool.cmcmtech.com', 'profile/$school/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      return jsonResponse['data'];
    } else {
      return false;
    }
  }

  getFatherProfileData(dynamic school, id) async {
    var url = Uri.https('mschool.cmcmtech.com', 'parentsProfile/$school/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      return jsonResponse['father'];
    } else {
      return false;
    }
  }
  getMotherProfileData(dynamic school, id) async {
    var url = Uri.https('mschool.cmcmtech.com', 'parentsProfile/$school/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      return jsonResponse['mother'];
    } else {
      return false;
    }
  }
}
