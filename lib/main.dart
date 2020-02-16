import 'package:flutter/material.dart';
import 'package:sfxp_meetup/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SFXP Meetup',
      home: HomeScreen(),
    );
  }
}