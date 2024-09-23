import 'package:get/get.dart';

import 'controller/profilecontroller.dart';
import 'widget/profileappbar.dart';
import 'widget/profiledata.dart';
import 'widget/profiletop.dart';
import 'widget/signoutbutton.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: profileappbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => ProfileTop(
              imglink: controller.userdata.value.profilepic,
              id: controller.userdata.value.id,
              name: controller.userdata.value.fullname,
              ontap: () => controller.uploadImage(context),
            ),
          ),
          64.heightBox,
          Obx(
            () => ProfileData(
              phoneNumber: controller.userdata.value.phonenumber!,
              email: controller.userdata.value.email,
              address: controller.userdata.value.address ?? "",
              username: controller.userdata.value.name,
            ),
          ),
          100.heightBox,
          SignoutButton(
            onPressed: () => controller.signout(),
          )
        ],
      ),
    );
  }
}
