import 'package:flutter/material.dart';

class TweenAnimationBuilderExample extends StatefulWidget {
  const TweenAnimationBuilderExample({super.key});

  @override
  _TweenAnimationBuilderExampleState createState() =>
      _TweenAnimationBuilderExampleState();
}

class _TweenAnimationBuilderExampleState
    extends State<TweenAnimationBuilderExample> {
  bool _isExpanded = false;

  void _toggleSize() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TweenAnimationBuilder Example'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _toggleSize,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 100, end: 200),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return Container(
                width: value,
                height: value,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Tap Me',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}