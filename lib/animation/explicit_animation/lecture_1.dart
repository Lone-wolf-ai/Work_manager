import 'package:flutter/material.dart';

class PositionedTransitionExample extends StatefulWidget {
  @override
  _PositionedTransitionExampleState createState() =>
      _PositionedTransitionExampleState();
}

class _PositionedTransitionExampleState
    extends State<PositionedTransitionExample>
    with TickerProviderStateMixin {
  late AnimationController _jerryController;
  late Animation<RelativeRect> _jerryAnimation;
  late AnimationController _tomController;
  late Animation<RelativeRect> _tomAnimation;
  late AnimationController _dogController;
  late Animation<RelativeRect> _dogAnimation;

  @override
  void initState() {
    super.initState();

    _jerryController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _jerryAnimation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
      end: const RelativeRect.fromLTRB(100, 100, 0, 0),
    ).animate(_jerryController);

    _tomController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _tomAnimation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
      end: const RelativeRect.fromLTRB(200, 200, 0, 0),
    ).animate(_tomController);

    _dogController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _dogAnimation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
      end: const RelativeRect.fromLTRB(300, 300, 0, 0),
    ).animate(_dogController);
  }

  @override
  void dispose() {
    _jerryController.dispose();
    _tomController.dispose();
    _dogController.dispose();
    super.dispose();
  }

  void _startAnimations() {
    _jerryController.forward();
    _tomController.forward();
    _dogController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PositionedTransition Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PositionedTransition(
                  rect: _jerryAnimation,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Image.asset(
                      'assets/jerry.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                PositionedTransition(
                  rect: _tomAnimation,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: Image.asset(
                      'assets/tom.png', // Replace with the actual path to Tom's image
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                PositionedTransition(
                  rect: _dogAnimation,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.green,
                    child: Image.asset(
                      'assets/dog.png', // Replace with the actual path to Dog's image
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _startAnimations,
            child: const Text('Start Animations'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PositionedTransitionExample(),
  ));
}
