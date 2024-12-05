import 'package:flutter/material.dart';

class AnimatedPhysicalModelExample extends StatefulWidget {
  const AnimatedPhysicalModelExample({super.key});

  @override
  State<AnimatedPhysicalModelExample> createState() => _AnimatedPhysicalModelExampleState();
}

class _AnimatedPhysicalModelExampleState extends State<AnimatedPhysicalModelExample> {
  bool _isElevated = false;

  void toggleElevation() {
    setState(() {
      _isElevated = !_isElevated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Physical Model Example'),
      ),
      body: Center(
        child: AnimatedPhysicalModel(
          shape: BoxShape.rectangle,
          elevation: _isElevated ? 164.0 : 0.0,
          color: Colors.blue,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(16.0),
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            child: const Text(
              'Animated Physical Model',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleElevation,
        child: const Icon(Icons.elevator),
      ),
    );
  }
}
