
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../home/widgets/taskbox.dart';
import '../controller/task_controller.dart';
import '../task_detail.dart';

class Reviewingtask extends StatelessWidget {
  const Reviewingtask({super.key});

  @override
  Widget build(BuildContext context) {
    final taskcontroller = Get.put(TaskController());

    return Scaffold(
      appBar: AppBar(
        title: "Reviewing".text.size(24).bold.white.make(),
        backgroundColor: Vx.gray600,
        foregroundColor: Vx.white,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: taskcontroller.reviewinglist.length,
          itemBuilder: (BuildContext context, int index) {
            final taskdata = taskcontroller.reviewinglist[index];

            return TaskBox(
                    taskdone: true,
                    onpress: () => Get.to(() =>
                        TaskDetail(taskdone: true,task: taskdata, onSubtaskUpdated: () {})),
                    title: taskdata.title.toString(),
                    total: taskdata.subtasks!.length,
                    deadline: taskdata.deadline.toString(), priority:taskdata.priority!,)
                .paddingSymmetric(vertical: 10, horizontal: 10);
          },
        ),
      ),
    );
  }
}
