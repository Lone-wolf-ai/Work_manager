import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../home/widgets/noticebox.dart';
import 'controller/noticecontroller.dart';

class NoticeList extends StatelessWidget {
  const NoticeList({super.key});

  @override
  Widget build(BuildContext context) {
    final NoticeController noticeController = Get.put(NoticeController());

    return Scaffold(
      appBar: AppBar(
        title: "Check All Notice".text.bold.size(24).white.make(),
        backgroundColor: Vx.gray600,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Obx(() {
          if (noticeController.isLoading.value && noticeController.notices.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            controller: ScrollController()
              ..addListener(() {
                if (noticeController.isLoading.value || !noticeController.hasMore.value) return;

                if (noticeController.notices.length % noticeController.batchSize == 0 &&
                    noticeController.notices.isNotEmpty) {
                  noticeController.fetchMoreNotices();
                }
              }),
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: noticeController.notices.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return NoticeBox(notice: noticeController.notices[index]).paddingSymmetric(vertical: 16);
                  },
                ),
                if (noticeController.isLoading.value) const CircularProgressIndicator().centered(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
