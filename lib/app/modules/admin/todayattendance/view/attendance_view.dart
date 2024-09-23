import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../data/models/attendance_admin.dart';
import '../widget/attendance_card.dart';

class AttendanceListView extends StatelessWidget {
  final List<AttendanceRecordAdminModel> records;

  const AttendanceListView({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Attendance Records".text.bold.size(22).make(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: records.map((record) => AttendanceCardAdmin(record:record )).toList(),
          ),
        ),
      ),
    );
  }
}