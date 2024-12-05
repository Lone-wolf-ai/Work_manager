import 'package:flutter/material.dart';



class AnimatedPositionedExample extends StatefulWidget {
  @override
  _AnimatedPositionedExampleState createState() => _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
  bool _isAnimated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedPositioned Example'),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            
            duration: const Duration(seconds: 1),
            left: _isAnimated ? 0 : 100,
            top: _isAnimated ? 0: 100,
            child: Image.asset('assets/jerry.png',height: 100,width: 120,),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            left: _isAnimated ? 0 : 200,
            top: _isAnimated ? 400 : 200,
            child:  Image.asset('assets/tom.png',height: 100,width: 120,),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            left: _isAnimated ? 100 : 300,
            top: _isAnimated ? 200 : 100,
            child:  Image.asset('assets/dog.png',height: 100,width: 120,),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isAnimated = !_isAnimated;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
