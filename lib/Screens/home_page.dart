import 'package:flutter/material.dart';
import 'package:mtech_school_app/Screens/home_screen.dart';
import 'package:mtech_school_app/utils/config.dart';
import 'package:mtech_school_app/widgets/dynamic_sizes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.09)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: dynamicHeight(context, 0.4),
                child: Image.network(
                    "https://media.istockphoto.com/vectors/education-logo-vector-id1181311065?k=20&m=1181311065&s=612x612&w=0&h=FtFo5zskhXpq7YHM5KC28ncMXopUnhiIgNYNUhM4KCI="),
              ),
              inputText("Email"),
              inputText("Password", password: true),
              Text(
                "Forgot Password?",
                style: TextStyle(color: myBlack.withOpacity(0.3)),
              ),
              SizedBox(
                height: dynamicHeight(context, 0.01),
              ),
              functionalButtons(context, "Login", Icons.arrow_forward,
                  const Color(0xff6dc9de), Colors.blue, function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              }),
              functionalButtons(context, "Login with Facebook", Icons.facebook,
                  const Color(0xff014b80), const Color(0xff014b80)),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "You don't have any Account?",
                    style: TextStyle(color: myBlack.withOpacity(0.3))),
                const TextSpan(
                    text: "Register", style: TextStyle(color: Colors.blue))
              ]))
            ],
          ),
        ),
      ),
    );
  }

  functionalButtons(context, text, icon, color1, color2, {function}) {
    return ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [color1, color2]),
                borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: dynamicWidth(context, 1),
              height: dynamicHeight(context, 0.07),
              alignment: Alignment.center,
              margin:
                  EdgeInsets.symmetric(horizontal: dynamicWidth(context, 0.05)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: dynamicWidth(context, 0.04), color: myWhite),
                  ),
                  Icon(
                    icon,
                    color: myWhite,
                  )
                ],
              ),
            )));
  }

  inputText(text, {password = false}) {
    return TextFormField(
      obscureText: password,
      decoration: InputDecoration(labelText: text),
    );
  }
}
