import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:sfxp_meetup/util/utils.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _controller = PageControls();

  @override
  void initState() {
    super.initState();
  }

  void _changeTab(int index) {
    if (mounted)
      setState(() {
        _controller.changeTab(index);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(
        builder: (_, dimens) => Stack(
          fit: StackFit.expand,
          children: [
            PageView(
              onPageChanged: (val) => _changeTab(val),
              children: <Widget>[
                Screen1(),
                Screen2(),
                Screen3(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 20,
                    width: dimens.maxWidth,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: FlareActor(
                      'assets/animations/3-indicators.flr',
                      fit: BoxFit.contain,
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Cinema Plus',
                    style: TextStyle(
                      fontFamily: "Product",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            )
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
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Transform(
            //   alignment: Alignment.topCenter,
            //   transform: Matrix4.identity()
            //     ..setEntry(3, 2, 0.002)
            //     ..rotateY(pi * _animation.value),
            //   child: GestureDetector(
            //     onTap: () {
            //       if (_animationStatus == AnimationStatus.dismissed) {
            //         _animationController.forward();
            //       } else {
            //         _animationController.reverse();
            //       }
            //     },
            //     // child: FlareActor(
            //     //   'assets/animations/spaceman.flr',
            //     //   fit: BoxFit.cover,
            //     //   animation: 'Untitled',
            //     // ),
            //     child: Image.asset(
            //       'assets/images/movie-theater.jpeg',
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            Positioned.fill(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/theater.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/movie-theater.jpeg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 245,
                    right: 90,
                    left: 90,
                    height: 113,
                    child: Container(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.002)
                        ..rotateX(pi * 0.032),
                      child: FlareActor(
                        'assets/animations/spaceman.flr',
                        fit: BoxFit.cover,
                        animation: 'Untitled',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'The Perfect Angle',
                    style: Utils.titleStyle,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Get access to the best seats in the house.',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Product'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/theater.jpg', fit: BoxFit.cover),
          Center(
            child: FlareActor(
              'assets/animations/barcode.flr',
              fit: BoxFit.contain,
              animation: 'scan',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Skip the Line',
                  style: Utils.titleStyle,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Quick access to all movie passes',
                  style: TextStyle(color: Colors.white, fontFamily: 'Product'),
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/space.jpg', fit: BoxFit.cover),
          Center(
            child: FlareActor(
              'assets/animations/Robot.flr',
              fit: BoxFit.contain,
              animation: 'buscando',
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 60),
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: GestureDetector(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                'Let\'s Go!',
                style: TextStyle(
                    color: Colors.purple[900],
                    fontFamily: 'Product',
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
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
