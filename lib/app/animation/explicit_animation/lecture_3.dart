import 'package:flutter/material.dart';

class RotationTransitionExample extends StatefulWidget {
  const RotationTransitionExample({super.key});

  @override
  _RotationTransitionExampleState createState() => _RotationTransitionExampleState();
}

class _RotationTransitionExampleState extends State<RotationTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isRotated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 16),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 25).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRotation() {
    if (_isRotated) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _isRotated = !_isRotated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotation Transition Example'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _toggleRotation,
          child: RotationTransition(
            turns: _animation,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child:  Center(
                child:Image.asset("assets/dog.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
