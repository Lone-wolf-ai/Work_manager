import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Color getColorFromString(String colorString) {
  switch (colorString.toLowerCase()) {
    case 'red':
      return Colors.redAccent;
    case 'blue':
      return Colors.blueAccent;
    case 'yellow':
      return Colors.yellowAccent;
    case 'green':
      return Colors.green;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    case 'pink':
      return Colors.pink;
    case 'brown':
      return Colors.brown;
    case 'gray':
    case 'grey': // Supporting both spellings
      return Vx.gray600;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    default:
      return Colors.transparent; // Default color if no match is found
  }
}
