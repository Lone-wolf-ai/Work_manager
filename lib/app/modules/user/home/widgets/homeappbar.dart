
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../data/service/api/locationtimecontroller.dart';
import '../../profile/controller/profilecontroller.dart';
import '../../profile/widget/customshimer.dart';

AppBar homeAppBar() {
  final profileController = Get.put(ProfileController());
  final locationTimeController = Get.put(LocationTimeController());

  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Vx.white,
    surfaceTintColor: Colors.grey,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          final data = profileController.userdata.value;
          return 'Hey ${data.name}'.text.bold.size(28).black.capitalize.make();
        }),
        5.heightBox,
        Obx(() {
          final hour = locationTimeController.datetime.value?.hour ?? DateTime.now().hour;
          final greeting = getGreeting(hour);
          return '$greeting Make your attendance'
              .text
              .semiBold
              .size(16)
              .black
              .make();
        }),
      ],
    ),
    actions: [
      Column(
        children: [
          Obx(() {
            final data = profileController.userdata.value;
            return CircleAvatar(
              backgroundColor: Colors.grey[400],
              radius: 28,
              child: ClipOval(
                child: data.profilepic != null
                    ? CachedNetworkImage(
                        width: 56,
                        height: 56,
                        imageUrl: data.profilepic ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CustomCircleShimmer(height: 56, width: 56),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person),
                      )
                    : const Icon(Icons.person, size: 100, color: Vx.gray700),
              ),
            )
                .box
                .roundedFull
                .border(color: Vx.white, width: 1.5)
                .make()
                .paddingSymmetric(horizontal: 16);
          }),
          "Admin".text.gray600.bold.make()
        ],
      ),
      
    ],
  );
}

String getGreeting(int hour) {
  if (hour < 12) {
    return 'Good Morning!';
  } else if (hour < 18) {
    return 'Good Afternoon!';
  } else {
    return 'Good Evening!';
  }
}
