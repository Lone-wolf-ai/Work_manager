import 'package:flutter/material.dart';

class AnimatedPositionedDirectionalExample extends StatefulWidget {
  @override
  _AnimatedPositionedDirectionalExampleState createState() => _AnimatedPositionedDirectionalExampleState();
}

class _AnimatedPositionedDirectionalExampleState extends State<AnimatedPositionedDirectionalExample> {
  double _left = 100.0;
  double _top = 100.0;

  void _moveImage(double left, double top) {
    setState(() {
      _left = left;
      _top = top;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedPositioned Directional Example'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            left: _left,
            top: _top,
            child: Image.asset(
              'assets/dog.png',
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () => _moveImage(_left - 100, _top),
                      child: const Text('Left'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => _moveImage(_left + 100, _top),
                      child: const Text('Right'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _moveImage(_left, _top - 100),
                      child: const Text('Up'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => _moveImage(_left, _top + 100),
                      child: const Text('Down'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}