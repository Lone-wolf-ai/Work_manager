import 'package:flutter/material.dart';

class AnimatedOpacityExample extends StatefulWidget {
  const AnimatedOpacityExample({super.key});

  @override
  State<AnimatedOpacityExample> createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  double _opacity = 1;

  void changeOpacity() {
    setState(() {
      _opacity = _opacity == 0.0 ? 1.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Opacity Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedOpacity(
              opacity: _opacity,
              curve: Curves.decelerate,
              duration: Duration(seconds: 1),
              child: Column(
                children: [
                  const Text(
                    "Tom and Jerry",
                    style: TextStyle(fontSize: 24),
                  ),
                  Image.asset('assets/jerry.png')
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeOpacity,
        child: const Icon(Icons.opacity),
      ),
    );
  }
}
