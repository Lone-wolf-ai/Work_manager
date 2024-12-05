import 'package:flutter/material.dart';

class Lecture1 extends StatefulWidget {
  const Lecture1({super.key});

  @override
  State<Lecture1> createState() => _Lecture1State();
}

class _Lecture1State extends State<Lecture1> {
  int _jerryAligned = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Align Example"),
      ),
      body: Stack(
        children: [
          AnimatedAlign(
            alignment: getjerry(_jerryAligned),
            duration: const Duration(seconds: 1),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.transparent,
              child: Image.asset('assets/jerry.png'),
            ),
          ),
          AnimatedAlign(
            alignment: getjerry(_jerryAligned),
            duration: const Duration(seconds: 1),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.transparent,
              child: Image.asset('assets/tom.png'),
            ),
          ),
          AnimatedAlign(
            alignment: gettom(_jerryAligned),
            duration: const Duration(seconds: 1),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.transparent,
              child: Image.asset('assets/dog.png'),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.abc),
          onPressed: () {
            setState(() {
              _jerryAligned = _jerryAligned + 1;
              
              if (_jerryAligned == 8) {
                _jerryAligned = 0;
              }
            });
          }),
    );
  }

  Alignment getjerry(int _jerryAligned) {
    switch (_jerryAligned) {
      case 1:
        return Alignment.topCenter;
      case 2:
        return Alignment.topRight;
      case 3:
        return Alignment.topLeft;
      case 4:
        return Alignment.center;
      case 5:
        return Alignment.centerLeft;
      case 6:
        return Alignment.centerRight;
      case 7:
        return Alignment.bottomCenter;
      case 8:
        return Alignment.bottomLeft;
      default:
        _jerryAligned = 0;
        return Alignment.bottomRight;
    }
  }
    Alignment gettom(int _jerryAligned) {
    switch (_jerryAligned) {
      case 1:
        return Alignment.topLeft;
      case 2:
        return Alignment.topRight;
      case 3:
        return Alignment.topCenter;
      case 4:
        return Alignment.center;
      case 5:
        return Alignment.centerLeft;
      case 6:
        return Alignment.centerRight;
      case 7:
        return Alignment.bottomCenter;
      case 8:
        return Alignment.bottomLeft;
      default:
        _jerryAligned = 0;
        return Alignment.bottomRight;
    }
  }
}
