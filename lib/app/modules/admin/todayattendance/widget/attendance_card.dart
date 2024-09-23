import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../data/models/attendance_admin.dart';

class AttendanceCardAdmin extends StatelessWidget {
  final AttendanceRecordAdminModel record;

  const AttendanceCardAdmin({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Vx.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          record.name.text.bold.make(),
          8.heightBox,
          'Date: ${record.date.toLocal().toIso8601String().split('T').first}'
              .text
              .gray400
              .make(),
          8.heightBox,
          'Check-In: ${record.checkInTime}'.text.make(),
          8.heightBox,
          'Check-Out: ${record.checkOutTime}'.text.make(),
          8.heightBox,
          'Location: ${record.location}'.text.make(),
        ],
      ),
    );
  }
}