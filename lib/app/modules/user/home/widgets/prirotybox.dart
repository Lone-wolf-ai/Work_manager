import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PriorityBox extends StatelessWidget {
  final String priority;

  const PriorityBox({super.key, required this.priority});

  Color _getColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Vx.red600;
      case 'medium':
        return Colors.orangeAccent;
      case 'low':
        return Vx.blue400;
      default:
        return Colors.grey; // Default color if none match
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getColor(priority),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Center(
        child: Text(
          priority,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ).paddingSymmetric(horizontal: 6, vertical: 4),
      ),
    );
  }
}
