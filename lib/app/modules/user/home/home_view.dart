
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:work_manger_tool/app/animation/pagetransition/pagescaletransition.dart';

import '../notice/controller/noticecontroller.dart';
import '../task/controller/task_controller.dart';
import '../task/task_detail.dart';
import 'widgets/checkincheckout.dart';
import 'widgets/homeappbar.dart';
import 'widgets/noticebox.dart';
import 'widgets/taskbox.dart';
import 'widgets/timeanddate.dart';
import 'widgets/titleandtextbutton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final noticeecontroller = Get.put(NoticeController());
    final taskcontroller = Get.put(TaskController());

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: homeAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16), // Unified padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TimeAndDate().paddingSymmetric(vertical: 8),
                const ChekInCheckOut(),
                36.heightBox,
                TitleAndTextButton(
                  title: "Announcement",
                  addfun: true,
                  onPressed: () {},
                ),
                8.heightBox,
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Obx(
                      () => ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: noticeecontroller.notices.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 4);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return NoticeBox(
                              notice: noticeecontroller.notices[index]);
                        },
                      ).box.height(120).make(),
                    );
                  },
                ),
                16.heightBox,
                // Obx(
                //   () => CustomSlider(
                //     action: () => controller.checkincheckout(),
                //     checkin: controller.checkedIn.value,
                //     checkout: controller.checkedOut.value,
                //   ),
                // ),
                // 32.heightBox,
                TitleAndTextButton(
                  title: 'Ongoing',
                  onPressed: () {},
                ),
                16.heightBox,
                Obx(
                  () => ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final taskdata = taskcontroller.ongoinglist[index];
                      final donenum = 0.obs;
                      donenum.value = taskcontroller
                          .ongoinglist[index].subtasks!
                          .where((v) => v.done!)
                          .length;
                      return Obx(
                        () => TaskBox(
                          ongoing: true,
                          onpress: () => Navigator.of(context).push(PageScaleTransition(page:TaskDetail(
                                task: taskdata,
                                onSubtaskUpdated: () {
                                  donenum.value = taskcontroller
                                      .ongoinglist[index].subtasks!
                                      .where((v) => v.done!)
                                      .length;
                                },
                              ) )),
                          done: donenum.value,
                          title: taskcontroller.ongoinglist[index].title!,
                          total: taskcontroller
                              .ongoinglist[index].subtasks!.length,
                          deadline: taskcontroller.ongoinglist[index].deadline!,
                          priority: taskcontroller.ongoinglist[index].priority!,
                        ),
                      );
                    },
                    separatorBuilder: (_, index) => const SizedBox(height: 16),
                    itemCount: taskcontroller.ongoinglist.length,
                  ),
                ),  
              ],
            ),
          ),
        ),
      ),
    );
  }
}



