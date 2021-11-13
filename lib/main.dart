import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtech_school_app/Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M-Tech School',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.kalamTextTheme(
          Theme.of(context).textTheme,
        ),
        fontFamily: 'Shalimar',
      ),
      home: const HomeScreen(),
    );
  }
}
