import 'package:flutter/material.dart';

class AniPad extends StatefulWidget {
  const AniPad({super.key});

  @override
  State<AniPad> createState() => _AniPadState();
}

class _AniPadState extends State<AniPad> {
  double _padding = 16.0;

  void changePadding() {
    setState(() {
      _padding = 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Padding Example'),
      ),
      body: Center(
        child: AnimatedPadding(
          padding: EdgeInsets.all(_padding),
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Container(
            color: Colors.blue,
            child: const Padding(
              padding: EdgeInsets.all(16.0), 
              child: Text(
                'Animated Padding',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changePadding,
        child: const Icon(Icons.padding),
      ),
    );
  }
}

