import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../user/home/widgets/homeappbar.dart';
import '../../../user/home/widgets/taskbox.dart';
import '../../../user/home/widgets/timeanddate.dart';
import '../../../user/task/controller/task_controller.dart';
import '../../../user/task/task_detail.dart';
import '../widgets/allbuttons.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskcontroller = Get.put(TaskController());
    return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Vx.white,
          appBar: homeAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const TimeAndDate().paddingSymmetric(vertical: 8),
                const AdminHomeButtons(),
                32.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    "Review Tasks".text.bold.size(24).gray900.make(),
                  ],
                ),
                16.heightBox,
                Obx(
                  () => ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final taskdata = taskcontroller.reviewinglist[index];
                      final donenum = 0.obs;
                      donenum.value = taskcontroller
                          .reviewinglist[index].subtasks!
                          .where((v) => v.done!)
                          .length;
                      return Obx(
                        () => TaskBox(
                          ongoing: true,
                          onpress: () => Get.to(() => TaskDetail(
                                task: taskdata,
                                onSubtaskUpdated: () {
                                  donenum.value = taskcontroller
                                      .reviewinglist[index].subtasks!
                                      .where((v) => v.done!)
                                      .length;
                                },
                              )),
                          done: donenum.value,
                          title: taskcontroller.reviewinglist[index].title!,
                          total: taskcontroller
                          .reviewinglist[index].subtasks!.length,
                          deadline: taskcontroller.reviewinglist[index].deadline!,
                          priority: taskcontroller.reviewinglist[index].priority!,
                        ),
                      );
                    },
                    separatorBuilder: (_, index) => const SizedBox(height: 16),
                    itemCount: taskcontroller.reviewinglist.length,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
