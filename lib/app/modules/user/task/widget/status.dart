import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class StatusBox extends StatelessWidget {
  final String status;

  const StatusBox({super.key, required this.status});

  Color _getColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'ongoing':
        return Vx.blue500;
      case 'reviewing':
        return Vx.orange500;
      case 'completed':
        return Colors.green;
      case 'on-hold':
        return Vx.gray400;
      default:
        return Colors.black; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getColor(status),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Center(
        child: Text(
          status,
          style:
              const TextStyle(color: Vx.white, fontWeight: FontWeight.bold),
        ).paddingSymmetric(horizontal: 6, vertical: 4),
      ),
    );
  }
}
