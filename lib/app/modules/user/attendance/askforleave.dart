import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:iconsax/iconsax.dart';
import 'controller/askforpermit_controller.dart';
import 'widget/askforleave/actionbuttons.dart';
import 'widget/askforleave/description.dart';
import 'widget/askforleave/titlefield.dart';

class LeaveApplication extends StatelessWidget {
  const LeaveApplication({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaveApplicationController controller =
        Get.put(LeaveApplicationController());

    return Scaffold(
      backgroundColor: Vx.white,
      appBar: AppBar(
        title: "Apply for Leave".text.bold.white.make(),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Vx.white,
            )),
        actions: [
          IconButton(
              onPressed: () => controller.uploadFile(),
              icon: const Icon(
                Iconsax.attach_circle,
                size: 32,
                color: Vx.white,
              ))
        ],
        backgroundColor: Vx.gray600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Title".text.bold.size(20).gray800.make(),
            8.heightBox,
            TitleTextField(controller: controller),
            16.heightBox,
            "Description".text.bold.size(20).gray800.make(),
            8.heightBox,
            DescriptionTextField(controller: controller).expand(),
            16.heightBox,
            ActionButtons(controller: controller),
            36.heightBox,
          ],
        ),
      ),
    );
  }
}
