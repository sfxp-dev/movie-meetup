import 'package:flutter/material.dart';

class OnboardingFlow extends StatefulWidget {
  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  static const int _pageCount = 5;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            children: <Widget>[
              Container(
                color: Colors.red.shade400,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'WELCOME TO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'CINEMAS PLUS',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              BenefitPage(
                color: Colors.red.shade500,
                title: 'No Online Fees',
                description:
                    'Save \$3.99 every time you purchase a movie ticket online by skipping the convenience fee!',
              ),
              BenefitPage(
                color: Colors.red.shade600,
                title: '1 Free Ticket',
                description:
                    'Enjoy 1 free movie ticket per month with Cinema Plus!',
              ),
              BenefitPage(
                color: Colors.red.shade700,
                title: '20% Off Snacks',
                description:
                    'A trip to the cinema isn\'t complete without snacks. Enjoy 20% off all concessions when you scan your Cinema Plus membership!',
              ),
              BenefitPage(
                color: Colors.red.shade800,
                title: 'Reward Points',
                description:
                    'Collect points for every dollar you spend and redeem your points for exclusive reward!',
                button: SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withOpacity(0.6),
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
                      Navigator.of(context).pushReplacementNamed('home');
                    },
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _pageCount; ++i)
                    PageIndicator(
                      isActive: _pageController.hasClients
                          ? _pageController.page >= (i - 0.5) &&
                              _pageController.page <= (i + 0.5)
                          : false,
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BenefitPage extends StatelessWidget {
  const BenefitPage({
    Key key,
    this.color,
    this.title,
    this.description,
    this.button,
  }) : super(key: key);

  final Color color;
  final String title;
  final String description;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 6),
            Expanded(
              flex: 4,
              child: Column(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.4,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: button,
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key key, this.isActive}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(isActive ? 0.6 : 0.2),
      ),
      child: SizedBox(),
    );
  }
}
