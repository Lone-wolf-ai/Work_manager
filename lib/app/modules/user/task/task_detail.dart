import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/utils/constants/string_const.dart';
import '../../../core/utils/popups/loaders.dart';
import '../../../data/models/subtask.dart';
import '../../../data/models/taskmodel.dart';
import '../home/widgets/prirotybox.dart';
import 'controller/task_controller.dart';
import 'widget/rounded_button.dart';
import 'widget/status.dart';
import 'widget/subtaskbox.dart';
import 'widget/taskdetailappbar.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail(
      {super.key,
      required this.task,
      required this.onSubtaskUpdated,
      this.taskdone = false});

  final TaskModel task;
  final VoidCallback onSubtaskUpdated;
  final bool taskdone;
  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    final completed = 0.obs;
    completed.value = task.subtasks!.where((element) => element.done!).length;
    return Scaffold(
      backgroundColor: Vx.white,
      floatingActionButton: taskdone == true
          ? null
          : (RoundedButton(
              onStart: () {
                if (task.status == StringConst.ongoing) {
                  if (completed.value == task.subtasks!.length) {
                    taskController
                        .taskupdate(task.id!, StringConst.reviewing)
                        .then((v) {
                      Loaders.successSnackBar(
                          title: "Submited",
                          message: "Your task is submited for reviewing");
                      
                    });
                    Get.back();
                  } else {
                    Loaders.warningSnackBar(
                        title: "Task not finished",
                        message:
                            "Please complete all subtask to complete task.");
                  }
                }
                if (task.status == StringConst.todo) {
                  taskController.taskupdate(task.id!, StringConst.ongoing).then(
                      (v) => Loaders.successSnackBar(
                          title: "Added to ongoing",
                          message: "Please check at home screen"));

                  Get.back();
                }
              },
              title: (task.status == StringConst.ongoing ? "Submit" : "Start"),
            )),
      appBar: taskdetailappbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            (task.title ?? '')
                .text
                .bold
                .capitalize
                .size(24)
                .gray800
                .make()
                .centered()
                .paddingOnly(top: 12, bottom: 12)
                .box
                .border(width: 2, color: Vx.gray500).rounded
                .make()
                .paddingSymmetric(vertical: 12),

            // deadline and Priority
            "Deadline: ${task.deadline}".text.size(20).semiBold.gray700.make(),
            16.heightBox,
            Row(
              children: [
                "Task-Priority: ".text.size(20).semiBold.gray700.make(),
                PriorityBox(priority: task.priority ?? ''),
              ],
            ),
            16.heightBox,
            Row(
              children: [
                "Status: ".text.size(20).semiBold.gray700.make(),
                StatusBox(
                  status: task.status ?? '',
                ),
              ],
            ),
            32.heightBox,
            Column(
              children: [
                "Summary".text.bold.size(24).make(),
                8.heightBox,
                // summary
                (task.detail ?? '')
                    .text
                    .size(16)
                    .gray700
                    .make()
                    .paddingOnly(bottom: 16),

                // download button
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.file_download,
                      color: Vx.white,
                    ),
                    onPressed: () {
                      // download action
                    },
                  ).box.roundedFull.gray600.make(),
                ),
              ],
            )
                .paddingSymmetric(horizontal: 8, vertical: 16)
                .box
                .rounded
                .border(width: 2.5, color: Vx.gray500)
                .make(),
            16.heightBox,
            // Subtasks
            "Subtasks".text.bold.size(22).gray800.make(),
            4.heightBox,
            "Please upload zip files here".text.semiBold.size(16).make(),
            16.heightBox,

            Column(
              children: [
                Obx(
                  () =>
                      "Completed ${completed.value} out of ${task.subtasks!.length} subtasks"
                          .text
                          .size(18)
                          .semiBold
                          .gray600
                          .make()
                          .paddingOnly(bottom: 16),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: task.subtasks?.length ?? 0,
                  itemBuilder: (context, index) {
                    Subtask subtask = task.subtasks![index];
                    return SubtaskBox(
                      title: subtask.title ?? '',
                      done: subtask.done ?? false,
                      onpress: () {
                        taskController.updateSubtask(
                          taskId: task.id!,
                          subtaskTitle: subtask.title!,
                          newDoneStatus: true,
                        );
                        completed.value++;
                        onSubtaskUpdated();
                      },
                      ongoing:
                          task.status == StringConst.ongoing ? true : false,
                      addAttachment: () async {
                        final data = await taskController.uploadFile();

                        taskController.updateSubtask(
                          taskId: task.id!,
                          subtaskTitle: subtask.title!,
                          newAttachmentLink: data,
                        );
                      },
                    ).paddingOnly(bottom: 8);
                  },
                ),
              ],
            ),
            120.heightBox,
          ],
        ),
      ).box.padding(const EdgeInsets.symmetric(horizontal: 16)).make(),
    );
  }
}


