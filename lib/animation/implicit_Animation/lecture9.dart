import 'package:flutter/material.dart';

class AnimatedCrossFadeExample extends StatefulWidget {
  @override
  _AnimatedCrossFadeExampleState createState() => _AnimatedCrossFadeExampleState();
}

class _AnimatedCrossFadeExampleState extends State<AnimatedCrossFadeExample> {
  bool _showFirstImage = true;

  void _toggleImage() {
    setState(() {
      _showFirstImage = !_showFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedCrossFade Example'),
      ),
      body: Center(
        child: GestureDetector(
          onTap:_toggleImage ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedCrossFade(
                firstCurve: Curves.bounceIn,
                secondCurve: Curves.decelerate,
                firstChild: Image.asset(
                  'assets/tom.png',
                  width: 150,
                  height: 150,
                ),
                secondChild: Image.asset(
                  'assets/jerry.png',
                  width: 150,
                  height: 150,
                ),
                crossFadeState: _showFirstImage
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(seconds: 1),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}