import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'Screens/home_screen.dart';

void main() {
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
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        pageTransitionsTheme: (Platform.isAndroid)
            ? const PageTransitionsTheme(
                builders: <TargetPlatform, PageTransitionsBuilder>{
                  TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                      transitionType: SharedAxisTransitionType.scaled),
                },
              )
            : const PageTransitionsTheme(
                builders: <TargetPlatform, PageTransitionsBuilder>{
                  TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
                      transitionType: SharedAxisTransitionType.scaled),
                },
              ),
      ),
      home: const HomeScreen(),
    );
  }
}
