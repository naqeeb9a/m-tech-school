import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mtech_school_app/Screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

loginUser(userCredentials) async {
  var response = await http.post(
      Uri.parse("http://mtechschool.cmcmtech.com/postlogin"),
      body: {"username": userCredentials[0], "password": userCredentials[1]});
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    return jsonData;
  } else {
    return false;
  }
}

checkLoginStatus(context, {function}) async {
  SharedPreferences saveUser = await SharedPreferences.getInstance();
  if (saveUser.getString("loginInfo") == null) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(),
        ),
        (Route<dynamic> route) => false);
  } else {
    function();
  }
}