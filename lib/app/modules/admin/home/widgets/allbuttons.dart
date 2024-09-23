import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../announce/view/announce_view.dart';
import '../../application/view/application_desk.dart';
import '../../employee/view/employee_view.dart';
import '../../task/view/task_view.dart';
import 'adminhomebutton.dart';

class AdminHomeButtons extends StatelessWidget {
  const AdminHomeButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Adminhomebutton(
          iconData: Iconsax.people,
          onPressed: () {
          Get.to(()=>const EmployeesView());
          },
          title: 'Employees',
          showAlert: true,
        ),
        Adminhomebutton(
          onPressed: ()=>Get.to(()=> const ApplicationDesk()),
          iconData: Iconsax.messages4,
          title: 'Application',
        ),
        Adminhomebutton(
          onPressed: ()=>Get.to(()=> const AdminTaskView()),
          iconData: Iconsax.task_square,
          title: 'Tasks',
        ),
        Adminhomebutton(
          onPressed: () =>Get.to(()=> const AnnounceView()),
          iconData: Iconsax.notification_1,
          title: 'Announce',
        )
      ],
    );
  }
}