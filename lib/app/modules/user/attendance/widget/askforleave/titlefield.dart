import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controller/askforpermit_controller.dart';

class TitleTextField extends StatelessWidget {
  final LeaveApplicationController controller;

  const TitleTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.titleController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    ).box.make();
  }
}
