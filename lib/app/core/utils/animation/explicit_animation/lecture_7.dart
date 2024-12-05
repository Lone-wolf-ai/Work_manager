import 'package:flutter/material.dart';

class PositionedDirectionalTransitionExample extends StatefulWidget {
  const PositionedDirectionalTransitionExample({super.key});

  @override
  _PositionedDirectionalTransitionExampleState createState() =>
      _PositionedDirectionalTransitionExampleState();
}

class _PositionedDirectionalTransitionExampleState
    extends State<PositionedDirectionalTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isMoved = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween<Offset>(begin: Offset.zero, end: const Offset(100, 100))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePosition() {
    if (_isMoved) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _isMoved = !_isMoved;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Positioned Directional Transition Example'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _togglePosition,
          child: SlideTransition(
            position: _animation,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  'Tap Me',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

