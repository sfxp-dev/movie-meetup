import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;
  final _controller = PageControls();

  @override
  void initState() {
    super.initState();
  }

  void _changeTab(int index) {
    if (mounted)
      setState(() {
        _controller.changeTab(index);
        _currentIndex = index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(
        builder: (_, dimens) => Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (val) => _changeTab(val),
                children: <Widget>[
                  Screen1(),
                  Screen2(),
                  Screen3(),
                ],
              ),
            ),
            Container(
              height: 20,
              width: dimens.maxWidth,
              margin: const EdgeInsets.only(bottom: 20),
              child: FlareActor(
                'assets/animations/3-indicators.flr',
                fit: BoxFit.contain,
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(end: 1, begin: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _animationStatus = status;
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationStatus == AnimationStatus.dismissed) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
      child: Column(
        children: <Widget>[
          Expanded(
              child: Center(
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY(pi * _animation.value),
              child: GestureDetector(
                onTap: () {
                  if (_animationStatus == AnimationStatus.dismissed) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                },
                child: FlareActor(
                  'assets/animations/spaceman.flr',
                  fit: BoxFit.contain,
                  animation: 'Untitled',
                ),
              ),
            ),
          )),
          Container(
            margin: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              children: <Widget>[
                Text(
                  'The Perfect Angle',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Get access to the best seats in the house.',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: FlareActor(
                'assets/animations/barcode.flr',
                fit: BoxFit.contain,
                animation: 'scan',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Skip the Line',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Quick access to all movie passes',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
          child: Center(
            child: FlareActor(
              'assets/animations/Robot.flr',
              fit: BoxFit.contain,
              animation: 'buscando',
            ),
          ),
        ),
        _buildButton(context),
      ],
    ));
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: GestureDetector(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.purple[900],
            ),
            child: Center(
              child: Text(
                'Let\'s Go!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
      ),
    );
  }
}

class PageControls extends FlareControls {
  int _lastIndex = 0;
  void changeTab(int index) {
    if (index != _lastIndex) {
      play('${_lastIndex + 1}-${index + 1}');
      _lastIndex = index;
    }
  }
}
