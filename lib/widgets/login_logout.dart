import 'dart:convert';

import 'package:http/http.dart' as http;

loginUser(userCredentials) async {
  var response = await http.post(
      Uri.parse("http://mschool.cmcmtech.com/postlogin"),
      body: {"username": userCredentials[0], "password": userCredentials[1]});
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    return jsonData;
  } else {
    return false;
  }
}
