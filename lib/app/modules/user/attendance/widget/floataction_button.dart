import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../askforleave.dart';

class AttendanceFloatButton extends StatelessWidget {
  const AttendanceFloatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(()=>const LeaveApplication());
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), 
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 16), 
        backgroundColor: Colors.green, 
        foregroundColor: Colors.white, 
      ),
      child: const Text(
        'Ask for Leave',
        style: TextStyle(
          fontSize: 16, 
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
