import 'package:flutter/material.dart';
import 'package:sfxp_meetup/onboarding/onboarding.dart';
import 'package:sfxp_meetup/ui/home.dart';

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
          return OnboardingFlow();
        },
        'home': (BuildContext context) {
          return HomeScreen();
        }
      },
//      home: OnboardingFlow(),
//      home: HomeScreen(),
    );
  }
}
