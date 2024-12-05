import 'package:flutter/material.dart';

class Lecture2 extends StatefulWidget {
  const Lecture2({super.key});

  @override
  State<Lecture2> createState() => _Lecture2State();
}

class _Lecture2State extends State<Lecture2> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.grey;
  double _radius = 20.0;
  _setAnimationValues() {
    setState(() {
      _color = Colors.orange;
      _radius = 40.0;
      _width = 200.0;
      _height = 200.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animated container"),),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _setAnimationValues();
          },
          child: AnimatedContainer(
            width: _width,
            height: _height,
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
                color: _color, borderRadius: BorderRadius.circular(_radius)),
            child: Image.asset("assets/jerry.png",height: 80,width: 80,),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            setState(() {
              _color = Colors.grey;
              _radius = 10.0;
              _width = 100.0;
              _height = 100.0;
            });
          });
        },
        child: const Icon(Icons.animation),
      ),
    );
  }
}
