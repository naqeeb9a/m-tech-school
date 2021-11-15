import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtech_school_app/Screens/home_screen.dart';
import 'package:mtech_school_app/utils/config.dart';

void main() {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: myWhite,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: myWhite,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  } else if (Platform.isIOS) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
  runApp(
    const MyApp(),
  );
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
