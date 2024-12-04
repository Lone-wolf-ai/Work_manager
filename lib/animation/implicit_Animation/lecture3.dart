import 'package:flutter/material.dart';

class Lecture3 extends StatefulWidget {
  const Lecture3({super.key});

  @override
  State<Lecture3> createState() => _Lecture3State();
}

class _Lecture3State extends State<Lecture3> {
  double _fontsize = 30.0;
  Color _color = Colors.grey;
  _dotAnimation() {
    setState(() {
      _fontsize = 50.0;
      _color = Colors.orange;
    });
  }
    _resetAnimation() {
    setState(() {
      _fontsize = 30.0;
      _color = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedDefaultTextStyle(
              style: TextStyle(fontSize: _fontsize, color: _color),
              curve: Curves.linear,
              duration: const Duration(milliseconds: 400),
              child: const Text("Animated default text style")),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {
                _dotAnimation();
              }, icon: const Icon(Icons.add)),
              IconButton(onPressed: () {
                _resetAnimation();
              }, icon: const Icon(Icons.plus_one))
            ],
          )
        ],
      ),
    );
  }
}
