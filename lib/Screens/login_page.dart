import 'package:flutter/material.dart';
import 'package:mtech_school_app/Screens/home_screen.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';
import 'package:mtech_school_app/widgets/essential_functions.dart';
import 'package:mtech_school_app/widgets/login_logout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var userCredentials = [];
    return Scaffold(
      backgroundColor: myGrey,
      body: (loading == true)
          ? Center(
              child: SizedBox(
                width: dynamicWidth(context, 0.3),
                child: const LinearProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: dynamicWidth(context, 0.1),
                ),
                height: dynamicHeight(context, 1),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: dynamicHeight(context, 0.4),
                        child: Image.asset("assets/school.png"),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, 0.08),
                      ),
                      inputText("Email", userCredentials, function: (value) {
                        if (value.isEmpty) {
                          return "Enter a Username";
                        }
                      }),
                      SizedBox(
                        height: dynamicHeight(context, 0.02),
                      ),
                      inputText("Password", userCredentials, password: true,
                          function: (value) {
                        if (value.isEmpty) {
                          return "password cannot be empty";
                        }
                      }),
                      SizedBox(
                        height: dynamicHeight(context, 0.1),
                      ),
                      functionalButtons(
                          context,
                          "Login",
                          Icons.arrow_forward,
                          primaryBlue,
                          primaryBlue.withOpacity(.01), function: () async {
                        setState(
                          () {
                            loading = true;
                          },
                        );
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          var response = await loginUser(userCredentials);
                          if (response["success"] == true) {
                            SharedPreferences saveUser =
                                await SharedPreferences.getInstance();
                            SharedPreferences saveUserSchool =
                                await SharedPreferences.getInstance();
                            saveUser.setString(
                                "loginInfo", response["user"]["id"].toString());
                            saveUserSchool.setString(
                                "school", response["school"].toString());
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const HomeScreen(),
                                ),
                                (Route<dynamic> route) => false);
                          } else {
                            setState(() {
                              loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Username Password invalid')),
                            );
                          }
                        }
                      }),
                      SizedBox(
                        height: dynamicHeight(context, 0.1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
