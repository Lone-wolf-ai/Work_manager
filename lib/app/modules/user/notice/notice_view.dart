import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/models/noticemodel.dart';

class NoticeView extends StatelessWidget {
  const NoticeView({super.key, this.notice});
  final Notice? notice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Notice".text.white.size(24).bold.make(),
        backgroundColor: Vx.gray600,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Vx.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              36.heightBox,
              notice!.title!.text.gray800.size(24).bold.make(),
              16.heightBox,
              "Date: ${notice!.date}".text.semiBold.gray600.size(24).make(),
              16.heightBox,
              notice!.description!.text.semiBold.gray800.size(18).make()
            ],
          ),
        ),
      ),
    );
  }
}
