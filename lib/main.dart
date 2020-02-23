import 'package:flutter/material.dart';

import 'onboarding/screen.dart';
import 'ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SFXP Meetup',
      routes: {
        '/': (BuildContext context) {
          return OnBoardingScreen();
        },
        '/home': (BuildContext context) {
          return HomeScreen();
        }
      },
    );
  }
}
