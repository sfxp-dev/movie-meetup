import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:sfxp_meetup/util/utils.dart';
import 'package:shake/shake.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final FULL_SCALE = 0.2;
  final SCALE_FRACTION = 0.8;

  final _controller = PageControls();
  PageController _pageController;
  final _slides = [Screen1(), Screen2(), Screen3()];
  var _page = 0.0;
  var _currentPage = 0;
  var _viewPortFraction = 0.9;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: _currentPage, viewportFraction: _viewPortFraction);
  }

  void _changeTab(int index) {
    if (mounted)
      setState(() {
        _currentPage = index;
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
            Image.asset('assets/images/theater.jpg', fit: BoxFit.cover),
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  setState(() {
                    _page = _pageController.page;
                  });
                }
                return true;
              },
              child: ScrollConfiguration(
                behavior: NoScrollBehavior(),
                child: PageView.builder(
                  onPageChanged: (val) => _changeTab(val),
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    final scale = max(
                        SCALE_FRACTION,
                        (FULL_SCALE - (index - _page).abs()) +
                            _viewPortFraction);
                    return Transform.scale(
                      scale: scale,
                      child: _slides[index],
                    );
                  },
                  itemCount: _slides.length,
                ),
              ),
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

class _Screen1State extends State<Screen1> {
  final _flareController = FlareControls();
  ShakeDetector detector;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      _flareController.play('stop');
      _flareController.play('shake');
      Future.delayed(Duration(milliseconds: 2300), () {
        _flareController.play('stop');
        _flareController.play('play');
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 100),
          Expanded(
            child: FlareActor(
              'assets/animations/popcorn.flr',
              fit: BoxFit.fitWidth,
              animation: 'play',
              controller: _flareController,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 100,
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'The Perfect Snack',
                  style: Utils.titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Enjoy a endless supply of your favorite food and drinks.',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Product',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final _flareController = FlareControls();
  var _ignorePoints = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          IgnorePointer(
            ignoring: _ignorePoints,
            child: GestureDetector(
              onTap: () {
                _flareController.play('success');
                setState(() => _ignorePoints = true);
              },
              child: FlareActor(
                'assets/animations/ticket.flr',
                fit: BoxFit.contain,
                animation: 'play',
                controller: _flareController,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 100.0),
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
          Center(
            child: FlareActor(
              'assets/animations/faces.flr',
              fit: BoxFit.contain,
              animation: 'play',
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
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 100),
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
